class AddTranslationsToSpreePage < ActiveRecord::Migration[5.1]
  def self.up
    params = {
      title: :string,
      nav_title: :string,
      path: :string,
      meta_title: :string,
      meta_description: :string,
      meta_keywords: :string
    }
    Spree::Page.create_translation_table! params
  end

  def self.down
    Spree::Page.drop_translation_table!
  end
end

