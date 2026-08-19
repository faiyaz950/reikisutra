$content = Get-Content -Path 'index.html' -Raw -Encoding UTF8
$quoteCorrect = Get-Content -Path 'quote.txt' -Raw -Encoding UTF8
$scrollCorrect = Get-Content -Path 'scroll.txt' -Raw -Encoding UTF8

$content = $content -replace '(?s)<!-- HINDI QUOTE -->.*?</blockquote>', $quoteCorrect
$content = $content -replace '(?s)<!-- SCROLL INDICATOR -->.*?</div>', $scrollCorrect

Set-Content -Path 'index.html' -Value $content -Encoding UTF8
Set-Content -Path 'index_utf8.html' -Value $content -Encoding UTF8
