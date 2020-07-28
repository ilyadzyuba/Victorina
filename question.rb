# encoding: utf-8
#
require 'rexml/document'

class Question

  def self.read_questions_from_xml(file_name)
    file = File.new(file_name, 'r:utf-8')
    doc = REXML::Document.new(file)
    file.close

    questions = []

    doc.elements.each('questions/question') do |questions_element|
      text = ''
      variants = []
      right_answer = 0

      questions_element.elements.each do |question_element|
        case question_element.name
        when 'text'
          text = question_element.text
        when 'variants'
          question_element.elements.each_with_index do |variant, index|
            variants << variant.text
            right_answer = index if variant.attributes['right']
          end
        end
      end

      questions << Question.new(text, variants, right_answer)
    end
    questions
  end

  def initialize(text, answer_variants, right_answer_index)
    @text = text
    @answer_variants = answer_variants
    @right_answer_index = right_answer_index
  end

  def ask
    @answer_variants.each_with_index do |variant, index|
      puts "#{index + 1}. #{variant}"
    end

    user_index = STDIN.gets.chomp.to_i - 1
    @correct = (@right_answer_index == user_index)
  end

  def correctly_answered?
    @correct
  end

  def show
    puts
    puts @text
  end
end
