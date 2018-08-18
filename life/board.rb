require_relative 'cell'

class Board
  attr_accessor :state, :step

  def initialize(args = {})
    width = args[:width] || 40
    height = args[:height] || 40

    @state = height.times.map do |row|
      width.times.map { |col| Cell.new(col, row, [0, 1].sample) }
    end
    @step = 1
  end

  def tick
    @step += 1

    @state = @state.map.with_index do |row, y|
      row.map.with_index do |cell, x|
        Cell.new(x, y, cell.next_state(@state))
      end
    end
  end
end
