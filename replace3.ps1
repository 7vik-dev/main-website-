$rootDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.niccolomiranda.com"
$files = Get-ChildItem -Path $rootDir -Recurse -File -Include *.html,*.js,*.css,*.ps1,*.bat

foreach ($file in $files) {
    if ($file.Name -match "replace") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    if ($content) {
        $updated = $content -replace "Gajjiï¿½ Sathvik", "Gajji Sathvik"
        $updated = $updated -replace "Gajjiï¿½", "Gajji"
        $updated = $updated -replace "Gajji Sathvik", "Gajji Sathvik"
        $updated = $updated -replace "Gajji", "Gajji"

        if ($content -cne $updated) {
            Set-Content -Path $file.FullName -Value $updated -NoNewline -Encoding UTF8
            Write-Host "Updated $($file.FullName)"
        }
    }
}
