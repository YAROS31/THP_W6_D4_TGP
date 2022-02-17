class CreateGossips < ActiveRecord::Migration[5.2]
  def change
    create_table :gossips do |t|
      t.string :title                     # Title of the gossip
      t.text :content                     # Content of the gossip
      t.belongs_to :user, index: true     # 1 gossip has 1 author only (an user)
      t.timestamps                        # Automated creation of 'created_at' & 'update_at' timestamps
    end
  end
end
