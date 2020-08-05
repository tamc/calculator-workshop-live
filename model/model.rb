require 'ffi'
require 'singleton'

class Model

  # WARNING: this is not thread safe
  def initialize
    reset
  end

  def reset
    C.reset
  end

  def method_missing(name, *arguments)
    if arguments.size == 0
      get(name)
    elsif arguments.size == 1
      set(name, arguments.first)
    else
      super
    end 
  end

  def get(name)
    return 0 unless C.respond_to?(name)
    ruby_value_from_excel_value(C.send(name))
  end

  def ruby_value_from_excel_value(excel_value)
    case excel_value[:type]
    when :ExcelNumber; excel_value[:number]
    when :ExcelString; excel_value[:string].read_string.force_encoding("utf-8")
    when :ExcelBoolean; excel_value[:number] == 1
    when :ExcelEmpty; nil
    when :ExcelRange
      r = excel_value[:rows]
      c = excel_value[:columns]
      p = excel_value[:array]
      s = C::ExcelValue.size
      a = Array.new(r) { Array.new(c) }
      (0...r).each do |row|
        (0...c).each do |column|
          a[row][column] = ruby_value_from_excel_value(C::ExcelValue.new(p + (((row*c)+column)*s)))
        end
      end 
      return a
    when :ExcelError; [:value,:name,:div0,:ref,:na,:num][excel_value[:number]]
    else
      raise Exception.new("ExcelValue type #{excel_value[:type].inspect} not recognised")
    end
  end

  def set(name, ruby_value)
    name = name.to_s
    name = "set_#{name[0..-2]}" if name.end_with?('=')
    return false unless C.respond_to?(name)
    C.send(name, excel_value_from_ruby_value(ruby_value))
  end

  def excel_value_from_ruby_value(ruby_value, excel_value = C::ExcelValue.new)
    case ruby_value
    when Numeric
      excel_value[:type] = :ExcelNumber
      excel_value[:number] = ruby_value
    when String
      excel_value[:type] = :ExcelString
      excel_value[:string] = FFI::MemoryPointer.from_string(ruby_value.encode('utf-8'))
    when TrueClass, FalseClass
      excel_value[:type] = :ExcelBoolean
      excel_value[:number] = ruby_value ? 1 : 0
    when nil
      excel_value[:type] = :ExcelEmpty
    when Array
      excel_value[:type] = :ExcelRange
      # Presumed to be a row unless specified otherwise
      if ruby_value.first.is_a?(Array)
        excel_value[:rows] = ruby_value.size
        excel_value[:columns] = ruby_value.first.size
      else
        excel_value[:rows] = 1
        excel_value[:columns] = ruby_value.size
      end
      ruby_values = ruby_value.flatten
      pointer = FFI::MemoryPointer.new(C::ExcelValue, ruby_values.size)
      excel_value[:array] = pointer
      ruby_values.each.with_index do |v,i|
        excel_value_from_ruby_value(v, C::ExcelValue.new(pointer[i]))
      end
    when Symbol
      excel_value[:type] = :ExcelError
      excel_value[:number] = [:value, :name, :div0, :ref, :na].index(ruby_value)
    else
      raise Exception.new("Ruby value #{ruby_value.inspect} not translatable into excel")
    end
    excel_value
  end


  module C 
    extend FFI::Library
    ffi_lib  File.join(File.dirname(__FILE__),FFI.map_library_name('model'))
    ExcelType = enum :ExcelEmpty, :ExcelNumber, :ExcelString, :ExcelBoolean, :ExcelError, :ExcelRange
                  
    class ExcelValue < FFI::Struct
      layout :type, ExcelType,
             :number, :double,
             :string, :pointer,
             :array, :pointer,
             :rows, :int,
             :columns, :int             
    end
  

    # use this function to reset all cell values
    attach_function 'reset', [], :void
    attach_function 'set_sheet1_b2', [ExcelValue.by_value], :void
    attach_function 'set_sheet1_b3', [ExcelValue.by_value], :void
    attach_function 'sheet1_b12', [], ExcelValue.by_value
    attach_function 'sheet1_c12', [], ExcelValue.by_value
    attach_function 'sheet1_d12', [], ExcelValue.by_value
    attach_function 'sheet1_e12', [], ExcelValue.by_value
    attach_function 'sheet1_f12', [], ExcelValue.by_value
    attach_function 'sheet1_g12', [], ExcelValue.by_value
    attach_function 'sheet1_h12', [], ExcelValue.by_value
    attach_function 'sheet1_b13', [], ExcelValue.by_value
    attach_function 'sheet1_c13', [], ExcelValue.by_value
    attach_function 'sheet1_d13', [], ExcelValue.by_value
    attach_function 'sheet1_e13', [], ExcelValue.by_value
    attach_function 'sheet1_f13', [], ExcelValue.by_value
    attach_function 'sheet1_g13', [], ExcelValue.by_value
    attach_function 'sheet1_h13', [], ExcelValue.by_value
    attach_function 'sheet1_b6', [], ExcelValue.by_value
    attach_function 'sheet1_b8', [], ExcelValue.by_value
    attach_function 'sheet1_b10', [], ExcelValue.by_value
    attach_function 'sheet1_c10', [], ExcelValue.by_value
    attach_function 'sheet1_d10', [], ExcelValue.by_value
    attach_function 'sheet1_e10', [], ExcelValue.by_value
    attach_function 'sheet1_f10', [], ExcelValue.by_value
    attach_function 'sheet1_g10', [], ExcelValue.by_value
    attach_function 'sheet1_h10', [], ExcelValue.by_value
    # end of Sheet1
    # Start of named references
    attach_function 'output_capacity_by_year', [], ExcelValue.by_value
    attach_function 'output_energy', [], ExcelValue.by_value
    attach_function 'output_revenue', [], ExcelValue.by_value
    attach_function 'output_years', [], ExcelValue.by_value
    attach_function 'input_capacity', [], ExcelValue.by_value
    attach_function 'input_load_factor', [], ExcelValue.by_value
    attach_function 'output_capacity_by_year', [], ExcelValue.by_value
    attach_function 'output_energy', [], ExcelValue.by_value
    attach_function 'output_revenue', [], ExcelValue.by_value
    attach_function 'output_years', [], ExcelValue.by_value
    attach_function 'set_input_capacity', [ExcelValue.by_value], :void
    attach_function 'set_input_load_factor', [ExcelValue.by_value], :void
    # End of named references
  end # C module
end # Model
