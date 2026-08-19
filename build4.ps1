Copy-Item index_utf8.bak.html index.html -Force

$content = Get-Content -Path 'index.html' -Raw -Encoding UTF8

# 1. Particles remove
$content = $content -replace '(?s)/\* PARTICLES \*/.*?@keyframes ptFloat \{.*?\}', '/* PARTICLES */
        #particles { display: none; }'

# 2. Hero Logo Wrapper
$content = $content -replace 'margin-bottom: -32px;', 'margin-bottom: -16px;'

# 3. Wordmark
$content = $content -replace 'font-weight: 700;', 'font-weight: 500;'
$content = $content -replace 'font-size: clamp\(44px, 6\.2vw, 86px\);', 'font-size: clamp(40px, 5.5vw, 76px);'
$content = $content -replace '#F8EDD4 0%, #E8C87A 55%, #C9972E 100%', '#F8EDD4 0%, #DDAF52 55%, #C9972E 100%'

# 4. Subtitle
$content = $content -replace 'color: rgba\(241, 230, 208, 0\.80\);', 'color: rgba(243, 231, 201, 0.90);'
$content = $content -replace 'margin-bottom: 16px;', 'margin-bottom: 24px;'

# 5. Quote Block
$content = $content -replace 'margin-bottom: 28px;', 'margin-bottom: 32px;'
$content = $content -replace 'background: rgba\(6, 10, 20, 0\.22\);', 'background: rgba(6, 10, 20, 0.08);'
$content = $content -replace 'backdrop-filter: blur\(6px\);', 'backdrop-filter: blur(4px);'
$content = $content -replace '-webkit-backdrop-filter: blur\(6px\);', '-webkit-backdrop-filter: blur(4px);'
$content = $content -replace 'border: 1px solid rgba\(221, 175, 82, 0\.12\);', 'border: 1px solid rgba(221, 175, 82, 0.05);'

# 6. CTA Button
$content = $content -replace 'background: linear-gradient\(135deg, #EEC85A, #C99830\);', 'background: linear-gradient(135deg, #F1D37A, #DDAF52);'
$content = $content -replace 'margin-bottom: 28px;', 'margin-bottom: 40px;'

# 7. Features Background
$content = $content -replace 'background: rgba\(6, 10, 22, 0\.48\);', 'background: rgba(6, 10, 22, 0.32);'
$content = $content -replace 'border: 1px solid rgba\(213, 162, 62, 0\.22\);', 'border: 1px solid rgba(221, 175, 82, 0.22);'
$content = $content -replace 'border-top: 1px solid rgba\(213, 162, 62, 0\.30\);', 'border-top: 1px solid rgba(221, 175, 82, 0.30);'

# 8. Feature hover
$content = $content -replace 'background: rgba\(213, 162, 62, 0\.07\);', 'background: rgba(221, 175, 82, 0.08);'

# 9. Feature lines
$content = $content -replace 'background: linear-gradient\(to bottom, transparent, rgba\(213,162,62,0\.20\), transparent\);', 'background: linear-gradient(to bottom, transparent, rgba(221, 175, 82, 0.25), transparent);'

# 10. Feature icon
$content = $content -replace 'stroke: #D5A23E;', 'stroke: #DDAF52;'
$content = $content -replace 'stroke: #E8C87A;', 'stroke: #F1D37A;'
$content = $content -replace 'filter: drop-shadow\(0 0 6px rgba\(213, 162, 62, 0\.35\)\);', 'filter: drop-shadow(0 0 8px rgba(221, 175, 82, 0.40));'

# 11. Feature text
$content = $content -replace 'color: #D5A23E;', 'color: #DDAF52;'
$content = $content -replace 'color: rgba\(235,222,198,0\.72\);', 'color: rgba(243,231,201,0.85);'

# Remove old JS particles block
$content = $content -replace '(?s)// Particles.*?\}\)\(\);', '// Particles removed'

# Add Gold Dust CSS
$goldDustCss = @'
        /* GOLD DUST (Subtle) */
        #gold-dust { position: absolute; inset: 0; z-index: 2; pointer-events: none; overflow: hidden; }
        .dust-pt { 
            position: absolute; 
            border-radius: 50%; 
            background: #DDAF52; 
            opacity: 0;
            animation: dustFloat linear infinite; 
        }
        @keyframes dustFloat {
            0% { transform: translateY(100vh) translateX(0); opacity: 0; }
            10% { opacity: var(--max-op, 0.15); }
            90% { opacity: var(--max-op, 0.15); }
            100% { transform: translateY(-10vh) translateX(var(--drift, 20px)); opacity: 0; }
        }

        /* BIRDS */
'@
$content = $content -replace '/\* BIRDS \*/', $goldDustCss

# Add Gold Dust JS
$goldDustJs = @'
    // Subtle Gold Dust
    (function() {
        const c = document.createElement('div');
        c.id = 'gold-dust';
        c.setAttribute('aria-hidden', 'true');
        const overlay = document.querySelector('.hero-overlay');
        if(overlay && overlay.parentNode) {
            overlay.parentNode.insertBefore(c, overlay.nextSibling);
        }
        
        const count = 8; // 5-10 extremely subtle particles
        for (let i = 0; i < count; i++) {
            const p = document.createElement('div');
            p.className = 'dust-pt';
            const s = Math.random() * 1.5 + 1; // 1px to 2.5px max
            const duration = Math.random() * 30 + 35; // 35s to 65s (very slow)
            const delay = Math.random() * -60;
            const drift = (Math.random() - 0.5) * 80; // random drift left or right
            const maxOp = Math.random() * 0.12 + 0.05; // very low opacity
            
            p.style.cssText = `
                width: ${s}px; 
                height: ${s}px; 
                left: ${Math.random() * 100}%; 
                animation-duration: ${duration}s; 
                animation-delay: ${delay}s;
                --drift: ${drift}px;
                --max-op: ${maxOp};
            `;
            c.appendChild(p);
        }
    })();

    // Scroll navbar background
'@
$content = $content -replace '// Scroll navbar background', $goldDustJs

# CINEMATIC REVEAL WITH UPDATED TIMINGS
# 1. Background animation
$content = $content -replace 'animation: sceneBreathe 20s ease-in-out infinite alternate;', 'animation: bgReveal 0.8s cubic-bezier(0.22, 1, 0.36, 1) both, sceneBreathe 20s ease-in-out infinite alternate;'

# 2. Navbar animation (targeting .navbar)
# FIX: Use $& to correctly preserve the matched block instead of destroying it
$content = $content -replace '(?s)\.navbar \{.*?transition: var\(--tr\);', "$& animation: navReveal 0.8s 0.2s cubic-bezier(0.22, 1, 0.36, 1) both;"

# 3. Logo wrapper
$content = $content -replace 'animation: fadeUp 1\.1s ease-out both;', 'animation: logoReveal 0.8s 0.6s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 4. Logo Aura
$content = $content -replace 'animation: auraGlow 9s ease-in-out infinite alternate;', 'animation: auraReveal 0.8s 0.9s cubic-bezier(0.22, 1, 0.36, 1) both, auraGlow 9s 1.7s ease-in-out infinite alternate;'

# 5. Logo Halo
$content = $content -replace 'animation: auraGlow 12s ease-in-out infinite alternate-reverse;', 'animation: auraReveal 0.8s 0.9s cubic-bezier(0.22, 1, 0.36, 1) both, auraGlow 12s 1.7s ease-in-out infinite alternate-reverse;'

# 6. Wordmark
$content = $content -replace 'animation: fadeUp 0\.9s 0\.05s ease-out both;', 'animation: fadeUpLg 0.8s 1.2s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 7. Subtitle
$content = $content -replace 'animation: fadeUp 1s 0\.15s ease-out both;', 'animation: fadeUpSm 0.8s 1.5s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 8. Ornament
$content = $content -replace 'animation: fadeUp 1s 0\.25s ease-out both;', 'animation: fadeUpSm 0.8s 1.8s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 9. Quote block
$content = $content -replace 'animation: fadeUp 1s 0\.35s ease-out both;', 'animation: fadeUpSm 0.8s 2.0s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 10. CTA Button
$content = $content -replace 'animation: fadeUp 1s 0\.45s ease-out both;', 'animation: fadeUpSm 0.8s 2.3s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 11. Features
$content = $content -replace 'animation: fadeUp 1s 0\.6s ease-out both;', 'animation: fadeUpLg 0.8s 2.6s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 12. Trust strip
$content = $content -replace 'animation: fadeUp 1s 0\.55s ease-out both;', 'animation: fadeUpLg 0.8s 2.8s cubic-bezier(0.22, 1, 0.36, 1) both;'

# 13. Replace @keyframes fadeUp block with the new keyframes
$keyframes = @'
        @keyframes bgReveal {
            0% { filter: saturate(1.1) contrast(1.02) brightness(0.3); }
            100% { filter: saturate(1.1) contrast(1.02) brightness(0.9); }
        }
        @keyframes navReveal {
            0% { opacity: 0; transform: translateY(-6px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        @keyframes logoReveal {
            0% { opacity: 0; transform: scale(0.96); }
            100% { opacity: 1; transform: scale(1); }
        }
        @keyframes auraReveal {
            0% { opacity: 0; }
            100% { opacity: 0.85; }
        }
        @keyframes fadeUpLg {
            0% { opacity: 0; transform: translateY(8px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeUpSm {
            0% { opacity: 0; transform: translateY(6px); }
            100% { opacity: 1; transform: translateY(0); }
        }
'@
$content = $content -replace '(?s)@keyframes fadeUp \{.*?\}', $keyframes

Set-Content -Path 'index.html' -Value $content -Encoding UTF8
Set-Content -Path 'index_utf8.html' -Value $content -Encoding UTF8
