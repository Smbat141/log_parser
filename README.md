# Smart Pension Log Parser
## Ruby Version
    Tested under version 3.0.0
## Tests
    Please be sure you have rspec already installed
    And then run 
```
rspec spec/test
```
## Benchmark
    I've tested some ways how can we itarete through file with 
    benchmarks and decided to use File.readlines method. Fastest way
    was File.read and then split it with /n symbol, but because diffarance
    was not that big I choose File.readlines just for simplicity

    you can check benchmarks by running
    
    ruby benchmarks.rb

## Run Parser
    To run the parser, simply pass the full path to the log file as an argument.
```
ruby parser.rb webserver.log
```

## Code Samples 
    parser = LogParser.new(file_path)
    sorted = parser.parse
    
    sorted.each do |key, value|
        puts "#{key} - #{value} visits"
    end
### Additional options
    There is two ways to parse, based on page_name and page_name_and_ip
    By default it's page_name and sorts by ASC, but if you want parse
    by another params you can just pass additional params
    
    
```
parser = LogParser.new(file_path, parse_by: "page_name_and_ip", sort_by: "DESC" )
sorted = parser.parse

sorted.each do |key, value|
    puts "#{key} - #{value} visits"
end
```

    Name and IP are parsed by regex patterns in ParserMixin Module
    Fill free to add or change patterns

## TODO
    1. Provide new class to print sorted result in more confortable way
    2. For oter types of parsers separate parsers common functionality and
       put it in abstract class
    3. Tests for Mixin moules
    4. Use Factory to generate log files for tests
    5. Create Gemfile with appropriate gems
    6. Create Docker image