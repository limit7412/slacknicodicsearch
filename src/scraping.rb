require 'nokogiri'
require 'open-uri'
require 'uri'

class Scraping
  def initialize(query)
    @query = query
    search_dic(query)
  end

  def get_top
    doc = Nokogiri::HTML.parse(@search_res[:html], nil, @search_res[:charset])
    @search_result = doc.xpath('//table[@class="menulist"]').css('a').attribute('href')
  end

  def get_dic
    url = "https://dic.nicovideo.jp" + @search_result
    dic_res = open_page(url)

    doc = Nokogiri::HTML.parse(dic_res[:html], nil, dic_res[:charset])

    return {
      pretext: "「#{@query}」について調べてきたよプロデューサー！",
      title: @query,
      title_link: url,
      text: "#{doc.xpath('//div[@class="article"]').css("p").inner_text}",
      color: "#FACC2E"
    }
  end

  private
  def search_dic(query)
    url = URI.escape("https://dic.nicovideo.jp/s/al/t/#{query}/rev_created/desc/1-")
    @search_res = open_page(url)
  end

  def open_page(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    return {
      html: html,
      charset: charset
    }
  end
end
