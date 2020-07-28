# encoding: UTF-8
#
# Мини-викторина (v.1) с хранением вопросов в отдельных файлах
#

# win hack
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

questions_path = current_path + "/data/questions.txt"
answers_path = current_path + "/data/answers.txt"

unless File.exist?(answers_path) && File.exist?(questions_path)
  abort 'Один из файлов не найден!'
end

# Считываем вопросы и ответы в массивы
questions_file = File.new(questions_path, "r:UTF-8")
questions = questions_file.readlines
questions_file.close

answers_file = File.new(answers_path, "r:UTF-8")
answers = answers_file.readlines
answers_file.close

correct_answers = 0
current_question = 0

puts "Мини-викторина. Ответьте на вопросы."

while current_question < questions.size

  puts
  puts questions[current_question]

  user_answer = STDIN.gets.encode("UTF-8").chomp
  correct_answer = answers[current_question].chomp

  if user_answer == correct_answer
    puts "Верный ответ!"
    correct_answers += 1
  else
    puts "Неправильно. Правильный ответ: " + correct_answer
  end
  current_question += 1
end

puts
puts "Правильных ответов: #{correct_answers} из #{questions.size}"
