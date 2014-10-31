class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :content
      t.integer :user_id
      t.string :title
      t.string :event

      t.timestamps
    end
    add_index :calendars, [:user_id, :created_at]
  end
end
