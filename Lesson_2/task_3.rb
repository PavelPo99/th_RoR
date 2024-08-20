fibonacci_numbers = [1, 1]

loop do
  last_num = fibonacci_numbers[-1] + fibonacci_numbers[-2]
  
  last_num >= 100 ? break : fibonacci_numbers << last_num
end

#puts fibonacci_numbers