require './lib/row_validator'
require './lib/column_validator'
require './lib/subgroup_validator'
require './lib/grid'

# validates a sudoku grid
class GridValidator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @grid = Grid.build(@puzzle_string)
  end

  def valid?
    (RowValidator.valid?(@grid) && ColumnValidator.valid?(@grid) && SubgroupValidator.valid?(@grid))
  end

  def complete?
    !@puzzle_string.include? '0'
  end
end
