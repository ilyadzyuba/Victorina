# encoding: UTF-8
#
# Мини-викторина (v.1.1) с хранением вопросов и ответов в XML файле
#
require 'rexml/document'
require_relative 'question'

# win hack
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)
file_name = current_path + "/questions.xml"

abort "XML файл не найден!" unless File.exist?(file_name)

questions = Question.read_questions_from_xml(file_name)

# Счетчик правильных ответов
right_answers_counter = 0

puts "Мини-викторина. Ответьте на вопросы."

questions.each do |question|
  question.show
  question.ask
  if question.correctly_answered?
    right_answers_counter += 1
    puts "Верно"
  else
    puts "Неверно"
  end
end

puts
puts "Правильных ответов: #{right_answers_counter} из #{questions.size}"
