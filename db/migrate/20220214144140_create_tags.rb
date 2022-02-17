class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :label                 # Label of the tag
      t.timestamps                    # Automated creation of 'created_at' & 'update_at' timestamps
    end
  end
end
