puts "Введите первую сторону треугольника: "
a = gets.chomp.to_f

puts "Введите вторую сторону треугольника: "
b = gets.chomp.to_f

puts "Введите третью сторону треугольника: "
c = gets.chomp.to_f

sides = [a, b, c].sort
hypotenuse, catheter_1, catheter_2 = sides

if catheter_1 ** 2 + catheter_2 ** 2 == hypotenuse ** 2
  puts "Данный треугольник: прямоугольный"
elsif (hypotenuse == catheter_1 || hypotenuse == catheter_2 || catheter_1 == catheter_2) && !(hypotenuse == catheter_1 && catheter_1 == catheter_2)
  puts "Данный треугольник: равнобедренный"
elsif hypotenuse == catheter_1 && catheter_1 == catheter_2
  puts "Данный треугольник: равносторонний"
end
