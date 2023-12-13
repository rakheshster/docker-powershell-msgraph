param([string]$version)
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

if ($version) {
    Write-Output "Downloading version $version of Microsoft.Graph module"
    Install-Module Microsoft.Graph -RequiredVersion $version
} else {
    Write-Output "Downloading latest version of Microsoft.Graph module"
    Install-Module Microsoft.Graph
}