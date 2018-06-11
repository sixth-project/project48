module ApplicationHelper

  def full_title(page_title = "")
    base_title = "Project48"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  require "uri"

  def text_url_to_link text #text_area内のURLのリンクを有効にする処理 http://freesworder.net/rails-link-a/

    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"

      text.gsub!(url, sub_text)
    end

    return text
  end


end
