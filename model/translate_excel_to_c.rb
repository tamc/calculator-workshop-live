#!/usr/bin/env ruby
require 'excel_to_code'

command = ExcelToC.new

command.excel_file = "model.xlsx"

command.output_name = "model"

command.named_references_that_can_be_set_at_runtime = ['capacity']
command.named_references_to_keep = ['output']

command.actually_run_tests = true

command.go!