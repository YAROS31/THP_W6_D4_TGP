class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :city_name         # Name of the related city
      t.string :zip_code          # Zip code of the related city (to offer search features on this field)
      t.timestamps                # Automated creation of 'created_at' & 'update_at' timestamps
    end
  end
end
