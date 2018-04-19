class AddTranslationsToSpreeBlog < ActiveRecord::Migration[5.1]
  def self.up
    params = {
      name: :string,
      permalink: :string
    }
    Spree::Blog.create_translation_table! params
  end

  def self.down
    Spree::Blog.drop_translation_table!
  end
end
