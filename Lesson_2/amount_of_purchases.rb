hash_res = {}


loop do
  puts "Введите название товара или слово 'стоп' если хотите закончить список: "
  product = gets.chomp.to_s

  break if product == 'стоп' || product == '1'

  puts "Введите цену за единицу товара: "
  price = gets.chomp.to_f

  puts "Введите кол-во купленного товара: "
  amount_of_goods = gets.chomp.to_f

  hash_res[product] = [price, amount_of_goods]

end

res_sum_products = 0

hash_res.each do |k, v|
  res_sum_products += v[0] * v[1]

  sum_products = v[0] * v[1]

  puts "#{k}: #{v[1]} штук(а) по #{v[0]} у.е. за штуку"

end

puts "Сумма за все покупки составила: #{res_sum_products}"