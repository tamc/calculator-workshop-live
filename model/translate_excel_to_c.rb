#!/usr/bin/env ruby
require 'excel_to_code'

command = ExcelToC.new

command.excel_file = "model.xlsx"

command.output_name = "model"

command.named_references_that_can_be_set_at_runtime = lambda do |name|
    name =~ /input/
end

command.named_references_to_keep = lambda do |name|
    name =~ /output/
end

command.actually_run_tests = true

command.go!