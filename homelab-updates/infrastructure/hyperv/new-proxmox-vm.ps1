#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Creates the Proxmox VE VM on the Surface Book 3, configured for nested
    virtualization on the LabNAT switch.

.DESCRIPTION
    Three settings make nested Proxmox work in Hyper-V:
      1. ExposeVirtualizationExtensions — passes VT-x into the VM so Proxmox
         can run its own VMs.
      2. MAC address spoofing — lets traffic from VMs inside Proxmox (which
         have their own MACs) pass through this VM's adapter.
      3. Static memory — Dynamic Memory doesn't work with nested
         virtualization.
    Secure Boot is turned off for this VM only so the Proxmox installer boots
    without a certificate-template change; the Surface Book itself keeps
    Secure Boot on.

    Safe to re-run: it stops if a VM with the same name already exists.

.NOTES
    Runbook: runbooks/hyperv-nat-and-proxmox.md (Step 2)
    Run new-labnat.ps1 first. Download the Proxmox VE ISO from
    https://www.proxmox.com/en/downloads into your Downloads folder first.
#>

$VMName     = "proxmox"
$SwitchName = "LabNAT"
$MemoryGB   = 16      # fixed; leaves ~16 GB for the Surface Book host
$CpuCount   = 4       # of 8 logical processors
$DiskGB     = 128

# 0. Prerequisites: the switch exists and no VM with this name exists
if (-not (Get-VMSwitch -Name $SwitchName -ErrorAction SilentlyContinue)) {
    Write-Warning "Switch $SwitchName not found. Run new-labnat.ps1 first."
    exit 1
}
if (Get-VM -Name $VMName -ErrorAction SilentlyContinue) {
    Write-Warning "A VM named '$VMName' already exists. Not changing it."
    exit 1
}

# 1. Find the newest Proxmox VE ISO in Downloads
$iso = Get-ChildItem -Path "$env:USERPROFILE\Downloads" -Filter "proxmox-ve_*.iso" -ErrorAction SilentlyContinue |
       Sort-Object LastWriteTime | Select-Object -Last 1
if (-not $iso) {
    Write-Warning "No proxmox-ve_*.iso found in $env:USERPROFILE\Downloads. Download it first."
    exit 1
}
Write-Host "[ok] Using ISO: $($iso.Name)"

# 2. Check free space where Hyper-V stores virtual disks
$vhdDir  = (Get-VMHost).VirtualHardDiskPath
$vhdPath = Join-Path $vhdDir "$VMName.vhdx"
$drive   = Get-PSDrive -Name ($vhdDir.Substring(0,1))
$freeGB  = [math]::Round($drive.Free / 1GB)
if ($freeGB -lt ($DiskGB + 20)) {
    Write-Warning "Only $freeGB GB free on $($drive.Name):. Need about $($DiskGB + 20) GB. Lower `$DiskGB or free space."
    exit 1
}
if (Test-Path $vhdPath) {
    Write-Warning "$vhdPath already exists. Move or delete it, then run again."
    exit 1
}
Write-Host "[ok] $freeGB GB free; disk will be $vhdPath"

# 3. Create the VM (Generation 2 = UEFI)
New-VM -Name $VMName -Generation 2 -MemoryStartupBytes ($MemoryGB * 1GB) `
       -NewVHDPath $vhdPath -NewVHDSizeBytes ($DiskGB * 1GB) -SwitchName $SwitchName | Out-Null
Write-Host "[ok] Created VM $VMName"

# 4. Nested-virtualization settings (VM must be off — it is, it was just created)
Set-VMMemory    -VMName $VMName -DynamicMemoryEnabled $false
Set-VMProcessor -VMName $VMName -Count $CpuCount -ExposeVirtualizationExtensions $true
Get-VMNetworkAdapter -VMName $VMName | Set-VMNetworkAdapter -MacAddressSpoofing On
Write-Host "[ok] Static memory, $CpuCount vCPUs, nested virtualization, MAC spoofing"

# 5. Boot from the installer ISO
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Add-VMDvdDrive -VMName $VMName -Path $iso.FullName
$dvd = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $dvd
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false
Write-Host "[ok] ISO attached as first boot device; Secure Boot off for this VM"

# 6. Summary — expect ExposeVirtualizationExtensions True, DynamicMemory False, MacAddressSpoofing On
Write-Host "`n--- Summary ---"
Get-VM -Name $VMName | Select-Object Name, State, ProcessorCount, @{n='MemoryGB';e={$_.MemoryStartup / 1GB}} | Format-Table
Get-VMProcessor -VMName $VMName | Select-Object ExposeVirtualizationExtensions | Format-Table
Get-VMMemory -VMName $VMName | Select-Object DynamicMemoryEnabled | Format-Table
Get-VMNetworkAdapter -VMName $VMName | Select-Object SwitchName, MacAddressSpoofing | Format-Table
