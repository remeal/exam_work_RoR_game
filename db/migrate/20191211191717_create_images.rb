class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.integer :number
      t.text :name
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
