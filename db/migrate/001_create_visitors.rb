class CreateVisitors < ActiveRecord::Migration[5.2]  # Specify the Rails version
  def change
    create_table :visitors do |t|
      t.string :ip_address, null: false
      t.text :user_agent
      t.datetime :visited_at, null: false

      t.timestamps
    end

    add_index :visitors, :ip_address
    add_index :visitors, :visited_at
  end
end
