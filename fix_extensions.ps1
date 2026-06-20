# Rename extensionless files in work/ directory
$workDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com\work"
Get-ChildItem -Path $workDir -File | Where-Object { $_.Extension -eq '' } | ForEach-Object {
    $newName = $_.FullName + '.html'
    Write-Host "Renaming: $($_.Name) -> $($_.Name).html"
    Rename-Item $_.FullName $newName
}

# Rename root-level extensionless HTML files
$rootDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com"

$filesToRename = @("about", "about@", "legal", "work@", "work.1")
foreach ($file in $filesToRename) {
    $fullPath = Join-Path $rootDir $file
    if (Test-Path $fullPath -PathType Leaf) {
        $newPath = $fullPath + ".html"
        if (Test-Path $newPath) {
            Write-Host "Removing existing: $newPath"
            Remove-Item $newPath -Force
        }
        Write-Host "Renaming: $file -> $file.html"
        Rename-Item $fullPath $newPath
    }
}

Write-Host "Done renaming files!"
