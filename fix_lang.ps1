$content = Get-Content -Path 'index.html' -Raw -Encoding UTF8

$quoteCorrect = @'
        <!-- HINDI QUOTE -->
        <blockquote class="quote-block" lang="hi">
            <span class="quote-mark">“</span>
            गति जब स्वयं में ठहर जाए तो वह स्थिरता है।<br/>
            यात्रा जब आरंभ और अंत से मुक्त हो जाए<br/>
            तो वह ब्रह्मांड की अनंत समृद्धि है।
            <span class="quote-mark">”</span>
        </blockquote>
'@

$content = $content -replace '(?s)<!-- HINDI QUOTE -->.*?</blockquote>', $quoteCorrect

$scrollCorrect = @'
    <!-- SCROLL INDICATOR -->
    <div class="scroll-indicator" aria-hidden="true">
        <span>↓</span>
        <span>SCROLL</span>
    </div>
'@

$content = $content -replace '(?s)<!-- SCROLL INDICATOR -->.*?</div>', $scrollCorrect

Set-Content -Path 'index.html' -Value $content -Encoding UTF8
Set-Content -Path 'index_utf8.html' -Value $content -Encoding UTF8
