class AddTranslationsToSpreePost < ActiveRecord::Migration[5.1]
  def self.up
    params = {
      title: :string,
      teaser: :string,
      body: :text
    }
    Spree::Post.create_translation_table! params
  end

  def self.down
    Spree::Post.drop_translation_table!
  end
end
