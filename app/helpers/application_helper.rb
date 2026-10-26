module ApplicationHelper
  # Текст поста хранится в Markdown, здесь он превращается в HTML.
  # filter_html вырезает HTML-теги из исходника, safe_links_only оставляет только обычные ссылки,
  # поэтому результат можно вставлять в страницу как есть
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, safe_links_only: true)
    parser = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, strikethrough: true)
    parser.render(text.to_s).html_safe
  end
end
