require 'minitest/autorun'
require 'nokogiri'

REDUCTION_FACTOR = 10

class CompressionTest < Minitest::Test
  def test_read_gpx
    content = File.read('test/sample.gpx')
    doc = Nokogiri::XML(content)
    doc.remove_namespaces!
    points = doc.xpath('//trkpt')
    assert points.count == 1608
  end

  def test_compression
    content = File.read('test/sample.gpx')
    doc = Nokogiri::XML(content)
    doc.remove_namespaces!
    points = doc.xpath('//trkpt')
    points.each_with_index do |point, idx|
      if idx % REDUCTION_FACTOR != 0
        point.remove
      end
    end
    points2 = doc.xpath('//trkpt')
    assert points2.count == 161
  end
end
