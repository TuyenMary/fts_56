3.times do |n|
  Subject.create!(name: "subject#{n+1}")
end
60.times do |i|
  Question.create!(name: "Question#{i+1}", subject_id: 1,
    user_id: 1)
end
