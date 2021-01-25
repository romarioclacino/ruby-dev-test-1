class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.integer :parent_id, index: true
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
end
