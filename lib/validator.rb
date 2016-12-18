# Validates a sudoku puzzle using the following process
# 1 - Parses/Clean up the sudoku grid (remove extra lines, characters, etc)
# 2 - Build array of arrays sudoku grid
# 3 - Check if rows are valid
# 4 - Check if columns are valid
# 5 - Check if regions are valid
# 6 - Check if game is completed (does not have 0 aka blanks)
class Validator
  VALID = 'This sudoku is valid.'.freeze
  INVALID = 'This sudoku is invalid.'.freeze
  VALID_INCOMPLETE = 'This sudoku is valid, but incomplete.'.freeze

  def initialize(puzzle_string)
    @grid = []
    @puzzle_string = puzzle_string
    build_grid
    validate
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    return INVALID unless valid?
    return VALID_INCOMPLETE unless complete?
    VALID
  end

  def valid?
    (valid_rows? && valid_columns? && valid_regions?)
  end

  private

  # This method parses sudoku files extensions
  # with specifi output format, if output changes
  # this method must be revised
  def build_grid
    grid = @puzzle_string.gsub(/\D/, '').chars.map(&:to_i).each_slice(9).to_a
    grid.each do |row|
      @grid << row.each_slice(3).to_a
    end
  end

  def valid_rows?
    @grid.map { |r| duplicate?(r) }.all? { |e| e == false }
  end

  def valid_columns?
    new_grid = @grid.map(&:flatten)
    new_grid.transpose.map { |c| duplicate?(c) }.all? { |e| e == false }
  end

  def valid_regions?
    regions = []
    @grid.each_slice(3) do |region|
      (0..2).each do |i|
        regions << duplicate?(region.transpose[i])
      end
    end
    # All region must not have duplicates
    regions.all? { |e| e == false }
  end

  def duplicate?(arr)
    result = arr.flatten.reject(&:zero?)
    result.uniq.size < result.size
  end

  def complete?
    !@puzzle_string.include? '0'
  end
end
