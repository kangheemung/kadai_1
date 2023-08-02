
class HomeController < ApplicationController
  require 'net/http'
  require 'rexml/document'
  require 'active_support/core_ext/hash'

  def top
    xml_url = URI('https://www.data.jma.go.jp/developer/xml/feed/extra.xml')
    xml_response = Net::HTTP.get(xml_url)
    xml_string = xml_response.force_encoding('UTF-8')
    xml_hash = Hash.from_xml(xml_string)

    id_hash = {}
    entries = xml_hash['feed']['entry']
    entries.each do |entry|
      id_hash[entry['title']] = {
        'content' => entry['content'],
        'name' => entry['name'],
        'id' => entry['id']
      }
    end

    @posts = id_hash
  end
end
