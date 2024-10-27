require_relative 'command'

# Implementation of Command class to subtract numbers
class SubInstruction < Command
  def initialize
    super("SUB")
  end

  # Subtract value in accumulator with data_register and set zero bit
  def execute(context)
    context.accumulator -= context.data_register
    context.zero_bit = (context.accumulator == 0)
  end
end