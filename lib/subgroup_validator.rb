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
      (0..2).each do |a|
        x = (a * 3)
        y = ((a + 1) * 3) - 1
        regions << duplicate?(region.transpose[x..y])
      end
    end
    regions.all? { |e| e == false }
  end
end
