module Download
  require 'open-uri'
  def mechanize_page(url)
    page = nil
    count = 5
    begin
      if count > 0
        count -= 1
        Timeout::timeout(3){
          page = Mechanize.new.get(url)
        }
      end
    rescue => e
      retry
    end
    return page
  end
  
  def download_document(url)
    doc = nil
    count = 5
    begin
      if count > 0
        count -= 1
        Timeout::timeout(3){
          doc = Nokogiri::HTML(open(url))
        }
      end
    rescue => e
      retry
    end
    return doc
  end

end