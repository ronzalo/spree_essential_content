class AddTranslationsToSpreeContent < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        params = {
          title: :string,
          body: :text,
          link: :string,
          link_text: :string,
          context: :string,
        }
        Spree::Content.create_translation_table! params
      end

      dir.down do
        Spree::Content.drop_translation_table!
      end
    end
  end
end
