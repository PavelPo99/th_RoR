puts "Введите коэффициент а: "
a = gets.chomp.to_f

puts "Введите коэффициент b: "
b = gets.chomp.to_f

puts "Введите коэффициент c: "
c = gets.chomp.to_f

dis = b**2 - 4 * a * c

if dis < 0
  puts "Корней нет"    
elsif dis > 0
  x_1 = (-b + Math.sqrt(dis)) / 2 * a
  x_2 = (-b - Math.sqrt(dis)) / 2 * a
  puts "Дискриминант = #{dis.to_i};\nПервый корень = #{x_1.round(2)};\nВторой корень = #{x_2.round(2)}."
else
  x_1 = (-b + Math.sqrt(dis)) / 2 * a
  puts "Дискриминант = #{dis.to_i};\nКорни уравнения = #{x_1.round(2)}."
end 