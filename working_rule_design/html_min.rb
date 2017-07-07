require 'html_press'
require 'nokogiri'
file = File.open("QuestionData_6.html", "r")
content = file.read
content =  HtmlPress.press(content)
@doc = Nokogiri::XML(content)
puts HtmlPress.press(@doc.xpath("//body")[0].attr("code"))