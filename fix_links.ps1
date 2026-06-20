# Fix all internal links in all HTML files
$rootDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com"

# Get all HTML files (root + work subdirectory)
$htmlFiles = Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content
    
    # Fix navigation links: work@ -> work@.html
    $content = $content -replace 'href="work@"', 'href="work@.html"'
    $content = $content -replace "href='work@'", "href='work@.html'"
    
    # Fix navigation links: about@ -> about@.html
    $content = $content -replace 'href="about@"', 'href="about@.html"'
    $content = $content -replace "href='about@'", "href='about@.html'"
    
    # Fix navigation links: about" -> about.html" (careful not to match about@)
    $content = $content -replace 'href="about"', 'href="about.html"'
    $content = $content -replace "href='about'", "href='about.html'"
    
    # Fix work.1 links
    $content = $content -replace 'href="work\.1"', 'href="work.1.html"'
    $content = $content -replace "href='work\.1'", "href='work.1.html'"
    
    # Fix legal links
    $content = $content -replace 'href="legal"', 'href="legal.html"'
    $content = $content -replace "href='legal'", "href='legal.html'"
    
    # Fix work/ subpage links (e.g., work/avroko -> work/avroko.html)
    # Match href="work/something" where something doesn't end in .html
    $content = $content -replace 'href="work/([^"\.]+)"', 'href="work/$1.html"'
    $content = $content -replace "href='work/([^'\.]+)'", "href='work/`$1.html'"
    
    # Fix prerender/prefetch links too
    $content = $content -replace 'href="work@"', 'href="work@.html"'
    $content = $content -replace 'href="about@"', 'href="about@.html"'
    
    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed links in: $($file.Name)"
    } else {
        Write-Host "No changes needed: $($file.Name)"
    }
}

Write-Host "`nDone fixing all links!"
