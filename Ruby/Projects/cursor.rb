# Install the ffi gem first by running: gem install ffi

require 'ffi'

module User32
  extend FFI::Library
  ffi_lib 'user32'
  attach_function :SetCursorPos, [:int, :int], :bool
  attach_function :GetCursorPos, [:pointer], :bool
end


def move_cursor(length)

  point = FFI::MemoryPointer.new(:long, 2) # POINT structure (x, y)
  if User32.GetCursorPos(point)
    x, y = point.read_array_of_long(2)
    # puts "Get Cursor position: (#{x}, #{y})"
  else
    puts "Failed to get cursor position."
  end

  x += length
  y += length

  if User32.SetCursorPos( x, y )
    puts "Set New Cursor position (#{x}, #{y})"
  else
    puts "Failed to move the cursor"
  end

  sleep rand(2..5)
end

while true
  puts "positive move" if move_cursor(rand(25..50))
  puts "negative move" if move_cursor(rand(-50..-25))
end