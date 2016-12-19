require './lib/sudoku_duplicate_checker'
# Validates all sudoku grid rows
class RowValidator
  include SudokuDuplicateChecker

  def self.valid?(grid)
    new(grid).valid?
  end

  def initialize(grid)
    @grid = grid
  end

  def valid?
    @grid.map { |r| duplicate?(r) }.all? { |e| e == false }
  end
end
