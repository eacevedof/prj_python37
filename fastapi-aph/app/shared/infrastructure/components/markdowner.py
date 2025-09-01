import re
from typing import List, Dict, final
from dataclasses import dataclass


@dataclass
class CodeBlockTmpType:
    html_with_tmp_code_tags: str
    html_pre_and_code_blocks: List[str]
    html_inline_code_blocks: List[str]


@final
class Markdowner:
    @staticmethod
    def get_instance():
        return Markdowner()
    
    def get_html_from_markdown(self, markdown: str) -> str:
        code_block_tmp_type = self.__get_code_tags(markdown)
        html_result = self.__get_a_tag(code_block_tmp_type.html_with_tmp_code_tags)
        
        html_result = self.__get_img_tags(html_result)
        html_result = self.__get_h1_h6_tags(html_result)
        html_result = self.__get_text_formatting_tags(html_result)
        html_result = self.__get_blockquote_tags(html_result)
        html_result = self.__get_hr_tags(html_result)
        html_result = self.__get_list_tags(html_result)
        
        # Restore code before paragraph processing
        html_result = self.__get_restored_tmp_code_tags(
            html_result,
            code_block_tmp_type.html_inline_code_blocks,
            code_block_tmp_type.html_pre_and_code_blocks
        )
        
        html_result = self.__get_p_tags(html_result)
        return html_result
    
    def __get_code_tags(self, html: str) -> CodeBlockTmpType:
        code_blocks = []
        
        def replace_code_block(match):
            lang = match.group(1) or ""
            code = match.group(2)
            placeholder = f"XZCODEBLOCKX{len(code_blocks)}XPLACEHOLDERX"
            escaped_code = (code
                           .replace("&", "&amp;")
                           .replace("<", "&lt;")
                           .replace(">", "&gt;")
                           .replace('"', "&quot;")
                           .replace("'", "&#39;"))
            
            lang_attr = f' class="language-{lang}"' if lang else ""
            code_blocks.append(f"<pre><code{lang_attr}>{escaped_code}</code></pre>")
            return placeholder
        
        html = re.sub(r'```(\w*)\n?([\s\S]*?)```', replace_code_block, html)
        
        inline_code_blocks = []
        
        def replace_inline_code(match):
            code = match.group(1)
            placeholder = f"XZINLINECODEX{len(inline_code_blocks)}XPLACEHOLDERX"
            escaped_code = (code
                           .replace("&", "&amp;")
                           .replace("<", "&lt;")
                           .replace(">", "&gt;")
                           .replace('"', "&quot;")
                           .replace("'", "&#39;"))
            inline_code_blocks.append(f"<code>{escaped_code}</code>")
            return placeholder
        
        html = re.sub(r'`([^`\n]+)`', replace_inline_code, html)
        
        return CodeBlockTmpType(
            html_with_tmp_code_tags=html,
            html_pre_and_code_blocks=code_blocks,
            html_inline_code_blocks=inline_code_blocks
        )
    
    def __get_a_tag(self, html: str) -> str:
        return re.sub(r'\[([^\]]+)\]\(([^)]+)\)', r'<a href="\2">\1</a>', html)
    
    def __get_img_tags(self, html: str) -> str:
        return re.sub(r'!\[([^\]]*)\]\(([^)]+)\)', r'<img alt="\1" src="\2">', html)
    
    def __get_h1_h6_tags(self, html: str) -> str:
        for i in range(6, 0, -1):
            pattern = f"^{'#' * i}\\s+(.*)$"
            html = re.sub(pattern, f"<h{i}>\\1</h{i}>", html, flags=re.MULTILINE)
        return html
    
    def __get_text_formatting_tags(self, html: str) -> str:
        # Bold and italic combined with asterisks
        html = re.sub(r'\*\*\*([^\*\n]+)\*\*\*', r'<strong><em>\1</em></strong>', html)
        
        # Bold and italic combined with underscores
        html = re.sub(r'___([^_\n]+)___', r'<strong><em>\1</em></strong>', html)
        
        # Bold with asterisks
        html = re.sub(r'\*\*([^\*\n]+)\*\*', r'<strong>\1</strong>', html)
        
        # Bold with underscores
        html = re.sub(r'(?<!_)__([^_\n]+)__(?!_)', r'<strong>\1</strong>', html)
        
        # Italic with asterisks
        html = re.sub(r'(?<!\*)\*([^\*\n]+)\*(?!\*)', r'<em>\1</em>', html)
        
        # Italic with underscores
        html = re.sub(r'(?<!_)_([^_\n]+)_(?!_)', r'<em>\1</em>', html)
        
        # Strikethrough
        html = re.sub(r'~~([^~\n]+)~~', r'<del>\1</del>', html)
        
        return html
    
    def __get_blockquote_tags(self, html: str) -> str:
        return re.sub(r'^> (.*)$', r'<blockquote>\1</blockquote>', html, flags=re.MULTILINE)
    
    def __get_hr_tags(self, html: str) -> str:
        return re.sub(r'^(---|\*\*\*|___)\s*$', '<hr>', html, flags=re.MULTILINE)
    
    def __get_list_tags(self, html: str) -> str:
        html_lines = html.split('\n')
        in_u_list = False
        in_o_list = False
        processed_lines = []
        
        for line in html_lines:
            is_u_list_item = bool(re.match(r'^(\s*[-*+])\s+(.*)$', line))
            is_o_list_item = bool(re.match(r'^\s*\d+\.\s+(.*)$', line))
            
            if is_u_list_item:
                if not in_u_list and in_o_list:
                    processed_lines.append("</ol>")
                    in_o_list = False
                if not in_u_list:
                    processed_lines.append("<ul>")
                    in_u_list = True
                processed_lines.append(re.sub(r'^(\s*[-*+])\s+(.*)$', r'<li>\2</li>', line))
                continue
            
            if is_o_list_item:
                if not in_o_list and in_u_list:
                    processed_lines.append("</ul>")
                    in_u_list = False
                if not in_o_list:
                    processed_lines.append("<ol>")
                    in_o_list = True
                processed_lines.append(re.sub(r'^\s*\d+\.\s+(.*)$', r'<li>\1</li>', line))
                continue
            
            if in_u_list:
                processed_lines.append("</ul>")
                in_u_list = False
            if in_o_list:
                processed_lines.append("</ol>")
                in_o_list = False
            if line.strip():
                processed_lines.append(line)
        
        # Close open lists
        if in_u_list:
            processed_lines.append("</ul>")
        if in_o_list:
            processed_lines.append("</ol>")
        
        return '\n'.join(processed_lines)
    
    def __get_p_tags(self, html: str) -> str:
        # Separate paragraphs by empty lines
        html = re.sub(r'\n\n+', '\n\n', html)
        paragraphs = [p for p in html.split('\n\n') if p.strip()]
        
        processed_paragraphs = []
        for paragraph in paragraphs:
            trimmed = paragraph.strip()
            
            # Don't wrap in <p> if already a block element
            if (trimmed.startswith("<h") or
                trimmed.startswith("<ul>") or
                trimmed.startswith("<ol>") or
                trimmed.startswith("<pre>") or
                trimmed.startswith("<blockquote>") or
                trimmed.startswith("<hr>") or
                "<pre><code" in trimmed):
                processed_paragraphs.append(trimmed)
                continue
            
            # If no line breaks, don't add <br>
            if '\n' not in trimmed:
                processed_paragraphs.append(f"<p>{trimmed}</p>")
                continue
            
            # Convert single line breaks to <br>
            with_breaks = trimmed.replace('\n', '<br>')
            processed_paragraphs.append(f"<p>{with_breaks}</p>")
        
        return '\n'.join(processed_paragraphs)
    
    def __get_restored_tmp_code_tags(
        self,
        html: str,
        html_inline_code_blocks: List[str],
        html_pre_and_code_blocks: List[str]
    ) -> str:
        # Restore inline code first
        for index, code_block in enumerate(html_inline_code_blocks):
            html = html.replace(f"XZINLINECODEX{index}XPLACEHOLDERX", code_block)
        
        # Restore code blocks
        for index, code_block in enumerate(html_pre_and_code_blocks):
            html = html.replace(f"XZCODEBLOCKX{index}XPLACEHOLDERX", code_block)
        
        return html