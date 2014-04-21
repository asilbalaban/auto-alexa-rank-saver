require 'net/http'
require 'rexml/document'
require 'date'

url = 'http://www.example.com'

xml_data = Net::HTTP.get_response(URI.parse('http://data.alexa.com/data?cli=10&data=snbamz&url='+url)).body
doc = REXML::Document.new(xml_data)

doc.elements.each('ALEXA/SD/POPULARITY') do |ele|
	$alexaValue =  ele.attributes["TEXT"]
	break
end

$today 	= Date.today
$echo 	= "#{$today} - #{$alexaValue} - #{url} \n"


File.open("alexa.txt", 'a+') {|f| f.write($echo) }