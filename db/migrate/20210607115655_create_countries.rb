class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso
      t.string :status
      t.text :quarantine
      t.text :test
      t.text :content
      t.string :government_url
      t.string :color
      t.text :upcoming_changes

      t.timestamps
    end
  end
end
