class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :student_id
      t.string :email
      t.string :labo
      t.string :profile

      t.timestamps
    end
  end
end
