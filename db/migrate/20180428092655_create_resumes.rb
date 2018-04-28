class CreateResumes < ActiveRecord::Migration[5.1]
  def change
    create_table :resumes do |t|
      t.string :student_name
      t.string :student_no
      t.string :programming_skills
      t.string :contact_information
      t.string :list_of_subjects
      t.string :hobbies_and_interests

      t.timestamps
    end
  end
end
