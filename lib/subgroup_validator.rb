require './lib/sudoku_duplicate_checker'
# Validates all sudoku grid subgroups
class SubgroupValidator
  include SudokuDuplicateChecker

  def self.valid?(grid)
    new(grid).valid?
  end

  def initialize(grid)
    @grid = grid
  end

  def valid?
    regions = []
    @grid.each_slice(3) do |region|
      regions << duplicate?(region.transpose[0..2])
    end
    # All region must not have duplicates
    regions.all? { |e| e == false }
  end
end
