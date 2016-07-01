3.times do |n|
  Subject.create!(name: "subject#{n+1}")
end
60.times do |i|
  Question.create!(content: "Question#{i+1}", subject_id: 1)
  2.times do |a|
    Answer.create!(content: "Content#{a+1}", question_id: i,
      correct: true)
  end
end
