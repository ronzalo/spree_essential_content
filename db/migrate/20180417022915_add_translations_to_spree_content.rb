class AddTranslationsToSpreeContent < ActiveRecord::Migration[5.1]
  def self.up
    params = {
      title: :string,
      body: :text,
      link: :string,
      link_text: :string,
      context: :string,
    }
    Spree::Content.create_translation_table! params
  end

  def self.down
    Spree::Content.drop_translation_table!
  end
end
