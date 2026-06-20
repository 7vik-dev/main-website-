$rootDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.niccolomiranda.com"
$files = Get-ChildItem -Path $rootDir -Recurse -File -Include *.html,*.js,*.css,*.ps1,*.bat

foreach ($file in $files) {
    if ($file.Name -match "replace") { continue }
    $content = Get-Content $file.FullName -Raw
    if ($content) {
        $updated = $content -replace "Niccol. Sathvik", "Gajji Sathvik"
        $updated = $updated -replace "Niccolï¿½ Sathvik", "Gajji Sathvik"
        $updated = $updated -replace "Niccol Sathvik", "Gajji Sathvik"
        $updated = $updated -replace "Niccolï¿½", "Gajji"
        $updated = $updated -replace "Niccol", "Gajji"
        
        # Finally replace any remaining Niccol<1-char>
        $updated = [System.Text.RegularExpressions.Regex]::Replace($updated, "Niccol.", "Gajji")

        if ($content -cne $updated) {
            Set-Content -Path $file.FullName -Value $updated -NoNewline -Encoding UTF8
            Write-Host "Updated $($file.FullName)"
        }
    }
}
