require 'sinatra'
require 'nokogiri'

REDUCTION_FACTOR = 10

configure do
  mime_type :gpx, 'application/gpx+xml'
end

get '/' do
  erb :index
end

post '/' do
  content = (params[:file][:tempfile]).read
  filename = params[:file][:filename]

  doc = Nokogiri::XML(content)
  doc.remove_namespaces!
  points = doc.xpath('//trkpt')

  points.each_with_index do |point, idx|
    if idx % REDUCTION_FACTOR != 0
      point.remove
    end
  end

  attachment filename
  doc.to_xml
end
