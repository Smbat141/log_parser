require_relative '../../parser'

RSpec.describe LogParser do

  let(:file_path) { File.expand_path("webserver_for_test.log", __dir__) }

  subject { described_class }

  def generate_logs(return_result_by: nil)
    return_result_by ||= "page_name"
    log_example_1 = "/help_page/1 897.280.786.156\n"
    log_example_2 = "/index 897.280.786.987\n"
    log_example_3 = "/about 835.255.778.987\n"
    invalid_log_example = "not_valid_page 8979875468765\n"

    four_random_numbers = Array.new(4) { rand(1...9) }

    File.open(file_path, 'w') do |file|
      four_random_numbers[0].times { file.write(log_example_1) }
      four_random_numbers[1].times { file.write(log_example_2) }
      four_random_numbers[2].times { file.write(log_example_3) }
      four_random_numbers[3].times { file.write(invalid_log_example) }
    end

    if return_result_by == "page_name"
      expected_result = [["/help_page/1", four_random_numbers[0]],
                         ["/index", four_random_numbers[1]],
                         ["/about", four_random_numbers[2]]]
    elsif return_result_by == "page_name_and_ip"

      expected_result = [[log_example_1.chomp, four_random_numbers[0]],
                         [log_example_2.chomp, four_random_numbers[1]],
                         [log_example_3.chomp, four_random_numbers[2]]]
    else
      return []
    end

    expected_result.sort_by { |first, second| second }
  end

  describe "LogParser - parse log files" do
    it "When file not exist" do
      expect { subject.new("invalid_file_name") }.to raise_error(("Please provide correct file name"))
    end

    it "When parsed by page_name and sorted by ASC" do
      expected_result = generate_logs
      parser = subject.new(file_path)
      result = parser.parse

      expect(result).to eq(expected_result)
    end

    it "When parsed by page_name and sorted by DESC" do
      expected_result = generate_logs.reverse
      parser = subject.new(file_path, { sort_by: "DESC" })
      result = parser.parse

      expect(result).to eq(expected_result)
    end

    it "When parsed by page_name_and_ip and sorted by ASC" do
      expected_result = generate_logs(return_result_by: "page_name_and_ip")
      parser = subject.new(file_path, { parse_by: "page_name_and_ip", sort_by: "ASC" })
      result = parser.parse

      expect(result).to eq(expected_result)
    end

    it "When parsed by page_name_and_ip and sorted by DESC" do
      expected_result = generate_logs(return_result_by: "page_name_and_ip").reverse
      parser = subject.new(file_path, { parse_by: "page_name_and_ip", sort_by: "DESC" })
      result = parser.parse

      expect(result).to eq(expected_result)
    end
  end
end