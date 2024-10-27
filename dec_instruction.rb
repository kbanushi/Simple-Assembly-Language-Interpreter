require_relative 'command'

# Implementation of Command class to support declaring variable
class DecInstruction < Command
  # Initialize with symbol name
  def initialize(symbol)
    super("DEC")
    @symbol = symbol
  end

  # Allocate a memory location for the symbol in data memory if not already defined
  def execute(context)
    unless context.symbol_table.key?(@symbol)
      address = context.next_available_data_address
      context.symbol_table[@symbol] = address
    end
  end
end