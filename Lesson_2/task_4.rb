id = 1
hash = {}
words = ("a".."z")
vowel_letters = ["a", "e", "i", "o", "u"]

words.each do |word|
  if vowel_letters.include?(word)
    hash[word] = id
  end
  id += 1
end

hash.each do |word, id|
  puts "#{word} - #{id}"
end