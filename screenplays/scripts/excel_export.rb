require 'rubyXL'
require 'html_minifier'
require 'nokogiri'
tally_list = {}
def get_screenplay
  screenplay_folder = File.join(File.dirname(__FILE__), "..")
  screenplays = {}
  standard_list = []
  Dir.entries(screenplay_folder).each do |folder|
    standard_list << folder[9..-1] if folder.include?('standard_')
  end
  standard_list.each do |std|
    standard_folder = File.join(File.dirname(__FILE__), "..", "standard_"+std)
    chapter_list = []
    Dir.entries(standard_folder).each do |folder|
      chapter_list << folder[8..-1].gsub(".html", "") if folder.include?('chapter_')
    end
    chapter_list.each do |chapter|
      file = File.join(File.dirname(__FILE__), "..", "standard_"+std, "chapter_"+chapter.to_s+".html")
      page = Nokogiri::HTML(open(file))
      page.css('body').each do |body|
        minified = body.to_s.gsub(/>\s*/, ">").gsub(/\s*</, "<").gsub(/"/,"'")
        # puts minified
        screenplays[body["code"].to_s]=minified
      end
    end
  end
  return screenplays
end

tally_list = get_screenplay
base_file = File.join(File.dirname(__FILE__), "Base_WorkingRule.xlsx")
book = RubyXL::Parser.parse(base_file)
master_sheet = book[0]

count = 0
master_sheet.each_with_index do |row,i|
  if row.cells[0]  && row.cells[0].value  && (['C06','C07'].include?row.cells[0].value ) && row.cells[1].value == 'Maths'
    if row.cells[26]
      master_sheet.add_cell( i,27, tally_list[row.cells[26].value.to_s])
    end
  end
  break if row.cells[0] && row.cells[0].value && (row.cells[0].value[0] == 'End')
end

book.save