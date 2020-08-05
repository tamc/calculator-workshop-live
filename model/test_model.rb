# coding: utf-8
# Test for model
require 'minitest/autorun'
require_relative 'model'

class TestModel < Minitest::Unit::TestCase
  def self.runnable_methods
    puts 'Overriding minitest to run tests in a defined order'
    methods = methods_matching(/^test_/)
  end
  def worksheet; @worksheet ||= init_spreadsheet; end
  def init_spreadsheet; Model.new end
  def test_sheet1_b12; assert_in_epsilon(6.0, worksheet.sheet1_b12, 0.002); end
  def test_sheet1_c12; assert_in_epsilon(6.6000000000000005, worksheet.sheet1_c12, 0.002); end
  def test_sheet1_d12; assert_in_epsilon(7.260000000000002, worksheet.sheet1_d12, 0.002); end
  def test_sheet1_e12; assert_in_epsilon(7.986000000000002, worksheet.sheet1_e12, 0.002); end
  def test_sheet1_f12; assert_in_epsilon(8.784600000000003, worksheet.sheet1_f12, 0.002); end
  def test_sheet1_g12; assert_in_epsilon(9.663060000000003, worksheet.sheet1_g12, 0.002); end
  def test_sheet1_h12; assert_in_epsilon(10.629366000000005, worksheet.sheet1_h12, 0.002); end
  def test_sheet1_b13; assert_in_epsilon(1.7999999999999998, worksheet.sheet1_b13, 0.002); end
  def test_sheet1_c13; assert_in_epsilon(1.98, worksheet.sheet1_c13, 0.002); end
  def test_sheet1_d13; assert_in_epsilon(2.1780000000000004, worksheet.sheet1_d13, 0.002); end
  def test_sheet1_e13; assert_in_epsilon(2.395800000000001, worksheet.sheet1_e13, 0.002); end
  def test_sheet1_f13; assert_in_epsilon(2.635380000000001, worksheet.sheet1_f13, 0.002); end
  def test_sheet1_g13; assert_in_epsilon(2.898918000000001, worksheet.sheet1_g13, 0.002); end
  def test_sheet1_h13; assert_in_epsilon(3.1888098000000014, worksheet.sheet1_h13, 0.002); end
  def test_sheet1_b6; assert_in_epsilon(15778.8, worksheet.sheet1_b6, 0.002); end
  def test_sheet1_b8; assert_in_epsilon(788940.0, worksheet.sheet1_b8, 0.002); end
  def test_sheet1_b10; assert_in_epsilon(2020.0, worksheet.sheet1_b10, 0.002); end
  def test_sheet1_c10; assert_in_epsilon(2021.0, worksheet.sheet1_c10, 0.002); end
  def test_sheet1_d10; assert_in_epsilon(2022.0, worksheet.sheet1_d10, 0.002); end
  def test_sheet1_e10; assert_in_epsilon(2023.0, worksheet.sheet1_e10, 0.002); end
  def test_sheet1_f10; assert_in_epsilon(2024.0, worksheet.sheet1_f10, 0.002); end
  def test_sheet1_g10; assert_in_epsilon(2025.0, worksheet.sheet1_g10, 0.002); end
  def test_sheet1_h10; assert_in_epsilon(2026.0, worksheet.sheet1_h10, 0.002); end
end
