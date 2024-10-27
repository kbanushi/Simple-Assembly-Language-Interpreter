require_relative 'command'

# Implementation of Command class that loads value pointed to by symbol to accumulator register
class LdaInstruction < Command
  # Initialize with symbol name
  def initialize(symbol)
    super("LDA")
    @symbol = symbol
  end

  # Load the value at the symbol’s address in data memory into the accumulator
  def execute(context)
    address = context.symbol_table[@symbol]
    context.accumulator = context.memory[address]
  end
end