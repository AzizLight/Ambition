module ApplicationHelper
  def markdown(text)
    options = {
      no_intra_emphasis: true,
      autolink: true,
      strikethrough: true,
      space_after_headers: true,
      superscript: true,
      fenced_code_blocks: true
    }
    syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(text)).html_safe
  end

  private

  def syntax_highlighter(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    doc.css("pre > code[class]").each do |code|
      code.parent.replace Pygments.highlight(code.text.rstrip, lexer: code[:class])
    end
    doc.to_s
  end
end
