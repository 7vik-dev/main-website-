# Update all HTML files to replace CDN URLs with local assets
$projectPath = "c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com"

# Find all HTML files except index.html and about.html (already done)
$htmlFiles = @(
    Join-Path $projectPath "work@.html"
    Join-Path $projectPath "about@.html"
    Join-Path $projectPath "work.1.html"
    Join-Path $projectPath "legal.html"
) + (Get-ChildItem -Path (Join-Path $projectPath "work") -Filter "*.html" | ForEach-Object { $_.FullName })

$replacements = @(
    @{ Old = "https://cdn.prod.website-files.com/5f2429f172d117fcee10e819/css/miranda-paper-portfolio.webflow.1c78bb630.min.css"; New = "../assets/css/miranda-paper-portfolio.webflow.min.css" },
    @{ Old = "https://cdn.jsdelivr.net/gh/locomotivemtl/locomotive-scroll/dist/locomotive-scroll.min.css"; New = "../assets/css/locomotive-scroll.min.css" },
    @{ Old = "https://cdn.jsdelivr.net/npm/locomotive-scroll@4.1.3/dist/locomotive-scroll.min.js"; New = "../assets/js/locomotive-scroll.min.js" },
    @{ Old = "https://cdnjs.cloudflare.com/ajax/libs/gsap/3.7.1/gsap.min.js"; New = "../assets/js/gsap.min.js" },
    @{ Old = "https://d3e54v103j8qbb.cloudfront.net/js/jquery-3.5.1.min.dc5e7f18c8.js?site=5f2429f172d117fcee10e819"; New = "../assets/js/jquery-3.5.1.min.js" },
    @{ Old = "https://unpkg.com/butter-slider"; New = "../assets/js/butter-slider.js" },
    @{ Old = "https://cdn.jsdelivr.net/gh/Gajjisathvik/portfolio@fa29f26/paper-curtain.mjs"; New = "../assets/js/paper-curtain.mjs" },
    @{ Old = "https://cdn.prod.website-files.com/5f2429f172d117fcee10e819/610a9b617744c726c80e42ec_favicon.png"; New = "../assets/images/favicon.png" },
    @{ Old = "https://cdn.prod.website-files.com/5f2429f172d117fcee10e819/610a9b23773de019356b2465_web-clip.png"; New = "../assets/images/web-clip.png" }
)

foreach ($file in $htmlFiles) {
    if (Test-Path $file) {
        $content = Get-Content -Path $file -Raw
        
        foreach ($replacement in $replacements) {
            $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
        }
        
        # For files in root directory, remove ../ prefix
        if ((Split-Path $file -Parent) -eq $projectPath) {
            $content = $content -replace "\.\.\/assets\/", "assets/"
        }
        
        Set-Content -Path $file -Value $content
        Write-Output "âœ“ Updated: $(Split-Path $file -Leaf)"
    }
}

Write-Output "`nAll files updated successfully!"
