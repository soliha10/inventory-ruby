module ApplicationHelper
  MARKDOWN_OPTIONS = {autolink: true, tables: true, fenced_code_blocks: true, strikethrough: true}.freeze

  def markdown(text) = sanitize(Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true), MARKDOWN_OPTIONS).render(text.to_s))
  def sort_header(query, attribute) = query ? sort_link(query, attribute, t("columns.#{attribute}")) : t("columns.#{attribute}")
  def row_link(url) = {controller: "row-link", row_link_url_value: url, action: "click->row-link#open" }
  def hint(text, type: "tooltip") = tag.span("?", class: "badge rounded-pill text-bg-secondary" , title: text, data: {controller: "bootstrap", bootstrap_type_value: type, bs_content: text } )
  def tag_cloud_size(tag, max) = "font-size: #{(0.9 + tag.uses.to_f / max).round(2)}rem "


end
