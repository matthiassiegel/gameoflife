class Cell
  def initialize(x, y, state)
    @x = x
    @y = y
    @state = state
  end

  def dead?
    @state == 0
  end

  def live?
    @state == 1
  end

  def next_state(cells)
    @cells = cells

    live_neighbours = live_neighbours_count
    new_state = @state

    if live?
      new_state = 0 if live_neighbours < 2 || live_neighbours > 3
    else
      new_state = 1 if live_neighbours == 3
    end

    new_state
  end

  private

  def live_neighbours_count
    count = 0
    count += 1 if live_neighbour_top?
    count += 1 if live_neighbour_right?
    count += 1 if live_neighbour_bottom?
    count += 1 if live_neighbour_left?
    count += 1 if live_neighbour_top_left?
    count += 1 if live_neighbour_top_right?
    count += 1 if live_neighbour_bottom_right?
    count += 1 if live_neighbour_bottom_left?
    count
  end

  def live_neighbour_top?
    return false if first_row?

    @cells[@y - 1][@x].live?
  end

  def live_neighbour_right?
    return false if last_cell_in_row?

    @cells[@y][@x + 1].live?
  end

  def live_neighbour_bottom?
    return false if last_row?

    @cells[@y + 1][@x].live?
  end

  def live_neighbour_left?
    return false if first_cell_in_row?

    @cells[@y][@x - 1].live?
  end

  def live_neighbour_top_left?
    return false if first_cell_in_row? || first_row?

    @cells[@y - 1][@x - 1].live?
  end

  def live_neighbour_top_right?
    return false if last_cell_in_row? || first_row?

    @cells[@y - 1][@x + 1].live?
  end

  def live_neighbour_bottom_right?
    return false if last_cell_in_row? || last_row?

    @cells[@y + 1][@x + 1].live?
  end

  def live_neighbour_bottom_left?
    return false if first_cell_in_row? || last_row?

    @cells[@y + 1][@x - 1].live?
  end

  def first_row?
    @y == 0
  end

  def last_row?
    @y == @cells.length - 1
  end

  def first_cell_in_row?
    @x == 0
  end

  def last_cell_in_row?
    @x == @cells[@y].length - 1
  end
end
