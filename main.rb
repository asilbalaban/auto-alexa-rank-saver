require 'net/http'
require 'rexml/document'
require 'date'

url = 'http://www.example.com'

xml_data = Net::HTTP.get_response(URI.parse('http://data.alexa.com/data?cli=10&data=snbamz&url='+url)).body
doc = REXML::Document.new(xml_data)

doc.elements.each('ALEXA/SD/POPULARITY') do |ele|
	$alexaValue =  ele.attributes["TEXT"].to_s
	break
end

# Son değeri kontrol et
lastLine = File.open("alexa.txt") { |f| f.extend(Enumerable).inject { |_,ln| ln } }
lastRank = lastLine.match(/- (.*?) -/).captures[0]

# Şimdiki ile aynıysa o zaman dosyaya ekleme yapma
if lastRank == $alexaValue
	puts "Deger ayni, yazma yok"
else
	# Eğer değer değiştiyse dosyaya ekle
	puts "Yeni deger kaydediliyor"

	$today 	= Date.today
	$echo 	= "#{$today} - #{$alexaValue} - #{url} \n"
	File.open("alexa.txt", 'a+') {|f| f.write($echo) }
end


