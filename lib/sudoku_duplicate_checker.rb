# Module that check for duplication for a given array
module SudokuDuplicateChecker
  def duplicate?(arr)
    result = arr.flatten.reject(&:zero?)
    result.uniq.size < result.size
  end
end
