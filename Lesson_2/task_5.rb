puts "Enter the day: "
day = gets.chomp.to_i

puts "Enter the month: "
month = gets.chomp.to_sym

puts "Enter the year: "
year = gets.chomp.to_i
puts ""

month_hash = {
  January: 31,
  February: [28, 29],
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

result = 0

if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
  month_hash.each do |m, d|
    if m == month
      result += day
      break
    else
      m == :February ? result += month_hash[:February][1] : result += d
    end
  end
  
  puts "Leap year."

else
  month_hash.each do |m, d|
    if m == month
      result += day
      break
    else
      m == :February ? result += month_hash[:February][0] : result += d
    end
  end
  puts "The year is not a leap year."
end


puts "The ordinal number of the date, starting from the beginning of the year #{result}"