@echo off
setlocal enabledelayedexpansion

REM Update all HTML files in work/ directory
cd /d "c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com"

REM PowerShell replacement script
powershell -NoProfile -Command ^
"$workDir = 'c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com\work'; ^
$files = Get-ChildItem -Path $workDir -Filter '*.html'; ^
$replacements = @( ^
    @{Old='https://cdn.prod.website-files.com/5f2429f172d117fcee10e819/css/miranda-paper-portfolio.webflow.1c78bb630.min.css'; New='../../assets/css/miranda-paper-portfolio.webflow.min.css'}, ^
    @{Old='https://cdn.jsdelivr.net/gh/locomotivemtl/locomotive-scroll/dist/locomotive-scroll.min.css'; New='../../assets/css/locomotive-scroll.min.css'}, ^
    @{Old='https://cdn.jsdelivr.net/npm/locomotive-scroll@4.1.3/dist/locomotive-scroll.min.js'; New='../../assets/js/locomotive-scroll.min.js'}, ^
    @{Old='https://cdnjs.cloudflare.com/ajax/libs/gsap/3.7.1/gsap.min.js'; New='../../assets/js/gsap.min.js'}, ^
    @{Old='https://d3e54v103j8qbb.cloudfront.net/js/jquery-3.5.1.min.dc5e7f18c8.js?site=5f2429f172d117fcee10e819'; New='../../assets/js/jquery-3.5.1.min.js'}, ^
    @{Old='https://unpkg.com/butter-slider'; New='../../assets/js/butter-slider.js'}, ^
    @{Old='https://cdn.jsdelivr.net/gh/Gajjisathvik/portfolio@fa29f26/paper-curtain.mjs'; New='../../assets/js/paper-curtain.mjs'}, ^
    @{Old='https://cdn.prod.website-files.com/5f2429f172d117fcee10e819/610a9b617744c726c80e42ec_favicon.png'; New='../../assets/images/favicon.png'}, ^
    @{Old='https://cdn.prod.website-files.com/5f2429f172d117fcee10e819/610a9b23773de019356b2465_web-clip.png'; New='../../assets/images/web-clip.png'} ^
); ^
foreach (\$file in \$files) { ^
    \$content = Get-Content -Path \$file.FullName -Raw; ^
    \$modified = \$false; ^
    foreach (\$r in \$replacements) { ^
        if (\$content -match [regex]::Escape(\$r.Old)) { ^
            \$content = \$content -replace [regex]::Escape(\$r.Old), \$r.New; ^
            \$modified = \$true ^
        } ^
    } ^
    if (\$modified) { ^
        Set-Content -Path \$file.FullName -Value \$content; ^
        Write-Host \"Updated: \$(\$file.Name)\" ^
    } ^
}"

echo.
echo All work files updated!
