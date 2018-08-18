require 'optparse'

require_relative 'life/board'
require_relative 'life/view'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: life.rb [options]'

  opts.on('--inverted', 'Invert cell colours') do |inverted|
    options[:inverted] = inverted
  end

  opts.on('--width [WIDTH]', Integer, 'Board width (columns)') do |width|
    next unless width

    options[:width] = width
  end

  opts.on('--height [HEIGHT]', Integer, 'Board height (rows)') do |height|
    next unless height

    options[:height] = height
  end

  opts.on('--interval [INTERVAL]', Float, 'Refresh interval (seconds)') do |interval|
    next unless interval

    options[:interval] = interval
  end

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

board = Board.new(options)
view = View.new(options)

view.render(board)

begin
  while true
    board.tick
    view.render(board)
    sleep options[:interval] || 0.5
  end
rescue Interrupt
  puts "\n"
  exit
end
