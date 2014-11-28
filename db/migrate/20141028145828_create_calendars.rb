class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :content
      t.integer :user_id
      t.string :date
      t.float :time

      t.timestamps
    end
    add_index :calendars, [:user_id, :created_at]
  end
end
