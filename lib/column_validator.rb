require './lib/sudoku_duplicate_checker'
# Validates all sudoku grid columns
class ColumnValidator
  include SudokuDuplicateChecker

  def self.valid?(grid)
    new(grid).valid?
  end

  def initialize(grid)
    @grid = grid
  end

  def valid?
    new_grid = @grid.map(&:flatten)
    new_grid.transpose.map { |c| duplicate?(c) }.all? { |e| e == false }
  end
end
