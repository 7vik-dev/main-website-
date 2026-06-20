# Fix all internal links in all HTML files - including work subpages
$rootDir = "c:\Users\Sathvikgg\Desktop\portfolio project\www.Gajjisathvik.com"

# Get all HTML files (root + work subdirectory)
$htmlFiles = Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content
    
    # Fix ../work@ -> ../work@.html (work subpage links going up)
    $content = $content -replace 'href="../work@"', 'href="../work@.html"'
    $content = $content -replace 'href=''../work@''', 'href=''../work@.html'''
    
    # Fix ../about@ -> ../about@.html
    $content = $content -replace 'href="../about@"', 'href="../about@.html"'
    $content = $content -replace 'href=''../about@''', 'href=''../about@.html'''
    
    # Fix ../about -> ../about.html (careful not to match ../about@)
    $content = $content -replace 'href="../about"', 'href="../about.html"'
    
    # Fix ../legal -> ../legal.html
    $content = $content -replace 'href="../legal"', 'href="../legal.html"'
    
    # Fix ../work.1 -> ../work.1.html
    $content = $content -replace 'href="../work\.1"', 'href="../work.1.html"'
    
    # Fix sibling work links (e.g., href="deplace-maison" -> href="deplace-maison.html")
    # These are relative links within the work/ directory pointing to other work pages
    # Only match if we're in the work directory
    if ($file.Directory.Name -eq "work") {
        # Match href="something" where something doesn't contain / or . or : or #
        # and is not index.html or an external URL
        $knownPages = @(
            "aquerone", "argor-heraeus", "avroko", "chiara-luzzana", "cobo", 
            "cobo-2019", "deplace-maison", "edoardo-smerilli", "loftgarten",
            "om-swami", "prada", "sal-parasuco", "the-books-of-ye",
            "the-hiring-chain", "the-roger-hub", "thinkers", "wow-concept"
        )
        foreach ($page in $knownPages) {
            $content = $content -replace "href=""$page""", "href=""$page.html"""
            $content = $content -replace "href='$page'", "href='$page.html'"
        }
    }
    
    # Fix prerender/prefetch link elements (same patterns)
    # ../work@ in link rel
    $content = $content -replace 'href="../work@"/>', 'href="../work@.html"/>'
    $content = $content -replace 'href="../about@"/>', 'href="../about@.html"/>'
    $content = $content -replace 'href="../legal"/>', 'href="../legal.html"/>'
    
    # Fix prefetch links for sibling pages (in work directory)
    if ($file.Directory.Name -eq "work") {
        foreach ($page in $knownPages) {
            $content = $content -replace "href=""$page""/>", "href=""$page.html""/>"
        }
    }
    
    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed links in: $($file.FullName)"
    } else {
        Write-Host "No changes needed: $($file.Name)"
    }
}

Write-Host "`nDone fixing all links!"
