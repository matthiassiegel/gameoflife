class View
  ANSI_CLEAR_SCREEN = "\e[H\e[2J".freeze
  ANSI_CLEAR_LINE = "\r\e[0K".freeze
  ANSI_MOVE_TO_PREV_LINE = "\e[1A".freeze

  LIVE = '◾'.freeze
  DEAD = '◽'.freeze

  def initialize(args = {})
    inverted = args[:inverted] || false

    @live = inverted ? DEAD : LIVE
    @dead = inverted ? LIVE : DEAD

    STDOUT.write ANSI_CLEAR_SCREEN
  end

  def render(board)
    rewind(board) unless board.step == 1

    board.state.each do |row|
      row.each { |cell| STDOUT.write cell.live? ? @live : @dead }

      STDOUT.write "\n"
    end

    STDOUT.write "\nStep: #{board.step}    Live: #{board.state.flatten.select(&:live?).count}\n\n"
  end

  private

  def rewind(board)
    (board.state.length + 4).times do
      STDOUT.write ANSI_CLEAR_LINE
      STDOUT.write ANSI_MOVE_TO_PREV_LINE
    end
  end
end
