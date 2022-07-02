require_relative 'parser_mixin'
require_relative 'sort_mixin'

class LogParser
  include ParserMixin
  include SortMixin

  def initialize(file_path, options = {})
    unless File.file?(file_path)
      raise "Please provide correct file name"
    end
    @file_path = file_path
    @options = options.transform_keys(&:to_sym)
  end

  def parse
    parsing_filed = @options[:parse_by] || "page_name"
    sort_by = @options[:sort_by] || "ASC"

    if parsing_filed == "page_name"
      parsed = parse_by_page_name(@file_path)
    elsif parsing_filed == "page_name_and_ip"
      parsed = parse_by_page_name_and_ip(@file_path)
    else
      raise "parse_by must be page_name or page_name_and_ip"
    end

    sort(parsed, sort_by)
  end
end

if __FILE__ == $0
  file_path = ARGV.first
  raise "Specify the file path as the first argument." if file_path.nil?
  parser = LogParser.new(file_path, { sort_by: "DESC" })
  sorted = parser.parse
  sorted.each do |key, value|
    puts "#{key} - #{value} visits"
  end

  puts "*************************************  Sorted By Unique"
  puts
  parser = LogParser.new(file_path, { parse_by: "page_name_and_ip", sort_by: "DESC" })
  sorted = parser.parse
  sorted.each do |key, value|
    puts "#{key} - #{value} unique views"
  end
end


















