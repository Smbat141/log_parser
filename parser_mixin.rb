module ParserMixin

  FIELD_PATTERNS = {
    name: /^\/([a-zA-Z_]+)+(\/+[0-9]+)?/,
    ip: /^([0-9]{3}\.)+([0-9]{3}$)/,
  }

  def parse_by_page_name(file_path)
    file_names = {}

    File.readlines(file_path).each do |line|
      line = line.chomp.split
      page_name = line.first.match(FIELD_PATTERNS[:name])

      if page_name.nil?
        next
      end

      page_name = page_name[0]

      file_names[page_name] = 0 if file_names[page_name].nil?
      file_names[page_name] += 1
    end

    file_names
  end

  def parse_by_page_name_and_ip(file_path)
    file_names = {}

    File.readlines(file_path).each do |line|
      line = line.chomp.split
      page_name = line[0].match(FIELD_PATTERNS[:name])
      ip = line[1].match(FIELD_PATTERNS[:ip])

      if page_name && ip
        concat_again = "#{page_name[0]} #{ip[0]}"
        file_names[concat_again] = 0 if file_names[concat_again].nil?
        file_names[concat_again] += 1
      end
    end

    file_names
  end
end