# Validates a sudoku puzzle
class Validator
  def initialize(puzzle_string)
    @grid = []
    @puzzle_string = puzzle_string
    build_grid(@puzzle_string)
    validate
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    valid = (validate_rows && validate_columns && validate_regions)
    complete = complete?
    return 'This sudoku is valid.' if valid && complete
    return 'This sudoku is valid, but incomplete.' if valid && !complete
    'This sudoku is invalid.'
  end

  def build_grid(puzzle)
    invalid_row = '------+------+------'
    grid = puzzle.delete(invalid_row).tr('|', '').split(/\n/).reject!(&:empty?)
    grid.each do |row|
      @grid << row.split(/\s/).map(&:to_i).each_slice(3).to_a
    end
  end

  private

  def validate_rows
    @grid.map { |r| dupe?(r) }.all?{ |e| e == false }
  end

  def validate_columns
    new_grid = @grid.map(&:flatten)
    new_grid.transpose.map { |c| dupe?(c) }.all?{ |e| e == false }
  end

  def validate_regions
    regions = []
    @grid.each_slice(3).with_index do |region|
      regions << dupe?(region.transpose[0])
      regions << dupe?(region.transpose[1])
      regions << dupe?(region.transpose[2])
    end
    # All region must not have duplicates
    regions.all? { |e| e == false }
  end

  def dupe?(arr)
    result = arr.flatten.each_with_object({}) do |e, a|
      (a.key?(e) ? a[e] += 1 : a[e] = 0) if e > 0
    end
    result.any? { |_, v| v.nonzero? }
  end

  def complete?
    !@puzzle_string.include? '0'
  end
end
