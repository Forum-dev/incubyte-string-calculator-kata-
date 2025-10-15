class StringCalculator
  # Adds numbers in a string, supporting commas, newlines, custom delimiters, and more
  def add(numbers)
    return 0 if numbers.empty?

    delimiter = /(,|\n)/
    if numbers.start_with?('//')
      delimiter, numbers = parse_custom_delimiters(numbers)
    end

    nums = parse_numbers(numbers, delimiter)
    check_negatives(nums)
    nums.reject { |n| n > 1000 }.sum
  end

  private

  # Parses custom delimiter(s) from prefix like //;\n or //[*][%]\n
  def parse_custom_delimiters(numbers)
    parts = numbers.split("\n", 2)
    delimiter_section = parts[0][2..] || ''

    delimiters = if delimiter_section.start_with?('[')
                   delimiter_section.scan(/\[([^\]]+)\]/).flatten
                 else
                   [delimiter_section]
                 end

    # Include comma and newline with custom delimiters as full patterns
    regex_delimiter = Regexp.new("(,|\n|#{delimiters.map { |d| Regexp.escape(d) }.join('|')})")
    [regex_delimiter, parts[1] || '']
  end

  # Splits string by delimiter and converts to integers, treating empty parts as 0
  def parse_numbers(numbers, delimiter = /(,|\n)/)
    numbers.split(delimiter).reject { |str| str.strip.empty? }.map do |num_str|
      num_str.to_i
    end
  end

  # Checks for negative numbers and raises with all listed
  def check_negatives(nums)
    negatives = nums.select { |n| n < 0 }
    raise RuntimeError, "negative numbers not allowed #{negatives.join(',')}" if negatives.any?
  end
end