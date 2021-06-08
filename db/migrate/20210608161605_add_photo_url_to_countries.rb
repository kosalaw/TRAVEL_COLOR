class AddPhotoUrlToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :photo_url, :string
  end
end
