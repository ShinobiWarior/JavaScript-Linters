require_relative 'parser'
class Variables
  attr_reader :all_vars

  def initialize(file, all_vars = {})
    @all_vars = all_vars
    @file = Parser.new(file)
    @lines = @file.lines
    create_variables
  end

  def repeats?
    values = []
    @all_vars.each_value do |val|
      values << val
    end
    values.uniq.length != values.length
  end

  def add_variable(name, line)
    @all_vars[line] = name if name
  end

  private

  def create_variables
    @lines.each_with_index do |line, idx|
      arr = line.split(' ')
      arr.each_with_index do |word, indx|
        add_variable(arr[indx + 1], idx + 1) if word.match(/const|var|let/)
      end
    end
  end
end
