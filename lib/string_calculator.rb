class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    
    delimiter = /[,|\n]/
    if numbers.start_with?('//')
      delimiter, numbers = parse_custom_delimiter(numbers)
    end

    nums = parse_numbers(numbers, delimiter)
    check_negatives(nums)
    nums.reject { |n| n > 1000 }.reduce(0, :+)
  end

  private

  def parse_custom_delimiter(numbers)
    parts = numbers.split("\n", 2)
    delimiter = parts[0][2..]
    [delimiter, parts[1]]
  end

  def parse_numbers(numbers, delimiter = /[,|\n]/)
    numbers.split(delimiter).map(&:to_i)
  end

  def check_negatives(nums)
    negatives = nums.select(&:negative?)
    raise RuntimeError, "negative numbers not allowed #{negatives.join(',')}" if negatives.any?
  end
end
