require_relative 'command'

# Implementation of Command class to swap values in accumulator in data_register
class XchInstruction < Command
  def initialize
    super("XCH")
  end

  # Exchange the contents of the accumulator and data register
  def execute(context)
    context.accumulator, context.data_register = context.data_register, context.accumulator
  end
end