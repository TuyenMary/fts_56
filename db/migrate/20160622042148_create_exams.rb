class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :subject, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :status
      t.integer :duration
      t.integer :question_number

      t.timestamps null: false
    end
    add_index :exams, [:subject_id, :user_id], unique: true
  end
end
