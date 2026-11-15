#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Creates the services lab network on the Surface Book 3: a Hyper-V internal
    switch with Windows NAT, so lab VMs get outbound access without being
    bridged onto the home network.

.DESCRIPTION
    Why an internal switch + NAT instead of an external switch:
    the Surface Book 3 is Wi-Fi only, and bridging a Hyper-V external switch
    over Wi-Fi is unreliable for nested guests (Proxmox VMs inside a VM).
    NAT keeps the lab on its own subnet, which is also the isolation I want.

    Safe to re-run: every step checks whether its change already exists and
    skips it if so. It stops (without changing anything further) on a subnet
    clash or a pre-existing NAT, because Windows generally allows only one
    NetNat at a time.

.NOTES
    Runbook: runbooks/hyperv-nat-and-proxmox.md (Step 1)
    Windows NAT does not hand out DHCP leases. VMs on this subnet use static
    addresses until OPNsense is added in Phase 2.
#>

$SwitchName = "LabNAT"
$GatewayIP  = "10.10.20.1"       # host side of the switch = gateway for lab VMs
$Prefix     = "10.10.20.0/24"
$IfAlias    = "vEthernet ($SwitchName)"

# 0. Hyper-V must be enabled
$hv = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
if ($hv.State -ne "Enabled") {
    Write-Warning "Hyper-V is not enabled. Enable it, reboot, then run this again."
    exit 1
}

# 1. Make sure 10.10.20.x isn't already used by the home network or another adapter
$clash = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
         Where-Object { $_.IPAddress -like "10.10.20.*" -and $_.InterfaceAlias -ne $IfAlias }
if ($clash) {
    Write-Warning "10.10.20.x is already used on '$($clash.InterfaceAlias)'. Pick another subnet before continuing."
    exit 1
}

# 2. Internal switch (host <-> VMs only; no physical adapter attached)
if (Get-VMSwitch -Name $SwitchName -ErrorAction SilentlyContinue) {
    Write-Host "[skip] Switch $SwitchName already exists"
} else {
    New-VMSwitch -Name $SwitchName -SwitchType Internal | Out-Null
    Write-Host "[ok] Created internal switch $SwitchName"
}

# 3. Host-side gateway IP on the switch's virtual adapter
if (Get-NetIPAddress -InterfaceAlias $IfAlias -IPAddress $GatewayIP -ErrorAction SilentlyContinue) {
    Write-Host "[skip] $GatewayIP already assigned to $IfAlias"
} else {
    New-NetIPAddress -InterfaceAlias $IfAlias -IPAddress $GatewayIP -PrefixLength 24 | Out-Null
    Write-Host "[ok] Assigned $GatewayIP to $IfAlias"
}

# 4. NAT for the lab subnet (Windows generally allows only one NetNat)
$nats = Get-NetNat -ErrorAction SilentlyContinue
if ($nats | Where-Object InternalIPInterfaceAddressPrefix -eq $Prefix) {
    Write-Host "[skip] NAT for $Prefix already exists"
} elseif ($nats) {
    Write-Warning "Another NAT already exists: $($nats.Name) ($($nats.InternalIPInterfaceAddressPrefix)). Not creating a second one."
    exit 1
} else {
    New-NetNat -Name $SwitchName -InternalIPInterfaceAddressPrefix $Prefix | Out-Null
    Write-Host "[ok] Created NAT $SwitchName for $Prefix"
}

# 5. Summary — expect LabNAT / Internal, 10.10.20.1/24, and a NAT for 10.10.20.0/24
Write-Host "`n--- Summary ---"
Get-VMSwitch -Name $SwitchName | Select-Object Name, SwitchType | Format-Table
Get-NetIPAddress -InterfaceAlias $IfAlias -AddressFamily IPv4 | Select-Object IPAddress, PrefixLength | Format-Table
Get-NetNat | Select-Object Name, InternalIPInterfaceAddressPrefix | Format-Table
