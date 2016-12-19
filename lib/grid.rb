# Builds a sudoku grid out of .sudoku file
class Grid
  def self.build(puzzle)
    new(puzzle).build
  end

  def initialize(puzzle)
    @puzzle = puzzle
    @grid = []
  end

  def build
    grid = @puzzle.gsub(/\D/, '').chars.map(&:to_i).each_slice(9).to_a
    grid.each do |row|
      @grid << row.each_slice(3).to_a
    end
  end
end
