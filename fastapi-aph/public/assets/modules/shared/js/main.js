// Main JavaScript for FastAPI Anti Phishing API

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the application
    initializeApp();
    
    // Add syntax highlighting to code blocks
    highlightCodeBlocks();
    
    // Add copy functionality to code blocks
    addCopyButtons();
});

function initializeApp() {
    console.log('FastAPI Anti Phishing API Documentation loaded');
    
    // Add smooth scrolling to anchor links
    const links = document.querySelectorAll('a[href^="#"]');
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

function highlightCodeBlocks() {
    const codeBlocks = document.querySelectorAll('pre code');
    codeBlocks.forEach(block => {
        // Add language-specific classes
        if (block.textContent.includes('{') && block.textContent.includes('}')) {
            block.classList.add('language-json');
        } else if (block.textContent.includes('curl')) {
            block.classList.add('language-bash');
        }
        
        // Add line numbers for longer code blocks
        if (block.textContent.split('\\n').length > 5) {
            addLineNumbers(block);
        }
    });
}

function addLineNumbers(codeBlock) {
    const lines = codeBlock.textContent.split('\\n');
    const numberedLines = lines.map((line, index) => {
        const lineNumber = (index + 1).toString().padStart(3, ' ');
        return `${lineNumber} | ${line}`;
    });
    codeBlock.textContent = numberedLines.join('\\n');
}

function addCopyButtons() {
    const codeBlocks = document.querySelectorAll('pre');
    codeBlocks.forEach(block => {
        const copyButton = document.createElement('button');
        copyButton.textContent = 'Copy';
        copyButton.className = 'copy-button';
        copyButton.style.cssText = `
            position: absolute;
            top: 10px;
            right: 10px;
            background: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        `;
        
        block.style.position = 'relative';
        block.appendChild(copyButton);
        
        copyButton.addEventListener('click', function() {
            const code = block.querySelector('code');
            if (code) {
                copyToClipboard(code.textContent);
                copyButton.textContent = 'Copied!';
                setTimeout(() => {
                    copyButton.textContent = 'Copy';
                }, 2000);
            }
        });
    });
}

function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text);
    } else {
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
    }
}

// API Testing utilities
function testEndpoint(url, method = 'GET', headers = {}, body = null) {
    const options = {
        method: method,
        headers: {
            'Content-Type': 'application/json',
            ...headers
        }
    };
    
    if (body && method !== 'GET') {
        options.body = JSON.stringify(body);
    }
    
    return fetch(url, options)
        .then(response => response.json())
        .then(data => {
            console.log('API Response:', data);
            return data;
        })
        .catch(error => {
            console.error('API Error:', error);
            throw error;
        });
}

// Export functions for external use
window.FastAPIUtils = {
    testEndpoint,
    copyToClipboard
};