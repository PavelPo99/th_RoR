puts "Как тебя зовут?"
name = gets.chomp.to_s
puts "Какой у тебя рост?"
weight = gets.chomp.to_i

ideal_weight = (weight - 110) * 1.15

if ideal_weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name.capitalize}, Bаш идеальный вес: #{ideal_weight.to_i}"
end