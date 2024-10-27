require_relative 'command'

# Implementation of Command class to store contents of accumulator into memory address pointed to by symbol
class StrInstruction < Command
  # Initialize with symbol name
  def initialize(symbol)
    super("STR")
    @symbol = symbol
  end

  # Store the accumulator's content in data memory at the symbol's address
  def execute(context)
    address = context.symbol_table[@symbol]
    context.memory[address] = context.accumulator
  end
end