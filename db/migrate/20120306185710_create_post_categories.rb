class CreatePostCategories < ActiveRecord::Migration[4.2]
  def self.up
    create_table :post_categories, :force => true do |t|
      t.string :name
      t.string :permalink
      t.timestamps
    end
  end

  def self.down
    drop_table :post_categories
  end
end
