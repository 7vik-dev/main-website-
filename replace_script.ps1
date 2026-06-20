$rootDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.niccolomiranda.com"
$files = Get-ChildItem -Path $rootDir -Recurse -File -Include *.html,*.js,*.css,*.ps1,*.bat

foreach ($file in $files) {
    if ($file.Name -match "replace_script.ps1") { continue }
    $content = Get-Content $file.FullName -Raw
    if ($content) {
        $updated = $content `
            -creplace "Niccolò Miranda", "Gajji Sathvik" `
            -creplace "Niccolo Miranda", "Gajji Sathvik" `
            -creplace "Niccolò", "Gajji" `
            -creplace "Niccolo", "Gajji" `
            -creplace "Miranda", "Sathvik" `
            -creplace "niccolomiranda", "gajjisathvik" `
            -creplace "Niccolomiranda", "Gajjisathvik"

        if ($content -cne $updated) {
            Set-Content -Path $file.FullName -Value $updated -NoNewline -Encoding UTF8
            Write-Host "Updated $($file.FullName)"
        }
    }
}
