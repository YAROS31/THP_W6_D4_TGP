class CreateGossipTags < ActiveRecord::Migration[5.2]
  def change
    create_table :gossip_tags do |t|
      t.belongs_to :gossip, index: true         # Link to a given gossip (to enable the gossip (N) <=> (N) tag relation)
      t.belongs_to :tag, index: true            # Link to a given tag (cf. above)
      t.timestamps                              # Automated creation of 'created_at' & 'update_at' timestamps
    end
  end
end
