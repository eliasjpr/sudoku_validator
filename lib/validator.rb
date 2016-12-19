require './lib/grid'
require './lib/grid_validator'
# Validates a sudoku game
class Validator
  VALID = 'This sudoku is valid.'.freeze
  INVALID = 'This sudoku is invalid.'.freeze
  VALID_INCOMPLETE = 'This sudoku is valid, but incomplete.'.freeze

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def initialize(puzzle_string)
    @grid_validator = GridValidator.new(puzzle_string)
    validate
  end

  def validate
    return INVALID unless @grid_validator.valid?
    return VALID_INCOMPLETE unless @grid_validator.complete?
    VALID
  end
end
