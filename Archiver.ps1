$Src = "Build"
$Dst = "Applications"

foreach ($ch in (Get-ChildItem -Directory $Src)) {
    $buildRoot = ($ch).FullName
    $buildName = ($ch).Name
    $archivePath = Join-Path $Dst "$buildName.zip"

    if ((Test-Path -Path $archivePath) `
        -and ((Get-Item $archivePath).LastWriteTime -ge ($ch).LastWriteTime)) {
        continue
    }

    Write-Host "Compress : $buildName"
    Compress-Archive -Path $buildRoot -DestinationPath $archivePath -Update
}

sleep 5