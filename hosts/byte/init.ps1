# Print a message to indicate the start of the download process
Write-Output "downloading latest NixOS WSL release..."

# Define the API URL for the latest release of NixOS WSL
$apiUrl = "https://api.github.com/repos/nix-community/nixos-wsl/releases/latest"

# Use Invoke-RestMethod to fetch the release data from GitHub API
$releaseData = Invoke-RestMethod -Uri $apiUrl -Headers @{Accept = "application/vnd.github.v3.json"}

# The name of the asset to download
$assetName = "nixos-wsl.tar.gz"

# Find the asset in the release data using its name
$asset = $releaseData.assets | Where-Object {$_.name -eq $assetName}

# Define the output path for the downloaded asset
$outputPath = Join-Path "$HOME\Downloads" $assetName

# Check if the asset was found
if ($asset -ne $null) {
    # Download the asset to the specified output path
    Start-BitsTransfer -Source $asset.browser_download_url -Destination $outputPath
} else {
    # Print an error message if the asset is not found
    Write-Error "asset named '$assetName' not found in the latest release."
    exit
}

# Attempt to add the new NixOS WSL distribution
Write-Output "importing NixOS WSL distribution..."

# Import the NixOS WSL distribution using the downloaded asset
wsl --import NixOS "$HOME/NixOS" $outputPath --version 2
if (-not $?) {
    Write-Error "error during WSL import"
    exit
}

# Define the binary path and NIX_PATH environment variable for Nix commands
$bin = "/run/current-system/sw/bin"
$nixPath = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels"

# Construct the command to execute in the NixOS WSL environment
$command = @"
export PATH=$bin && \
    export NIX_PATH=$nixPath && \
    nix-channel --update && \
    nixos-rebuild switch && \
    nix-shell -p git --run 'git clone https://github.com/putquo/nixconf' && \
    nix-shell -p git --run 'nixos-rebuild boot --flake nixconf/.#byte' && \
    rm -rf nixconf
"@

# Execute the command in the NixOS WSL distribution as root
wsl -d NixOS --user root -- $bin/bash -c $command

# Check if the command execution was successful
if ($?) {
  # Terminate the NixOS session
  wsl -t NixOS
  # Run and immediately exit a root session
  wsl -d NixOS --user root exit
  # Terminate the NixOS session again for good measure
  wsl -t NixOS
  # Set the default WSL distro
  wsl -s NixOS
  Write-Output "successfully initialised NixOS distribution"
} else {
    Write-Error "error during NixOS initialization"
    exit
}

