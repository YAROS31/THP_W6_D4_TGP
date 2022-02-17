class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content                     # Text of the comment
      t.references :user, index: true     # 1 comment has 1 and only 1 author (an user)
      t.references :gossip, index: true   # 1 comment is linked to a 'gossip' XOR to another 'comment'
      t.references :comment, index: true  # How to manage this XOR link: (i) routing method testing which link is !nil? (ii) Via polymorphism?
      t.timestamps                        # Automated creation of 'created_at' & 'update_at' timestamps
    end
  end
end
