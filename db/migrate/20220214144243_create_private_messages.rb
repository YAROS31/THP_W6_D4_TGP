class CreatePrivateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :private_messages do |t|
      t.string :object                              # Title of the message
      t.text :body                                  # Content of the message
      t.boolean :read                               # 'true' if the message has been displayed / read already by the 'recirpient', false elseway
      t.references :sender, index: true             # 1 'user' is the 'sender' (NB: remember to use "class_name: 'User'" in the related ApplicationRecord)
      t.references :recipient, index: true          # 1 'user' is the 'recipient' (NB: remember to use "class_name: 'User'" in the related ApplicationRecord)
      t.references :previous_message, index: true   # Link to the previous message (NB: remember to use "class_name: 'PrivateMessages'" in the relevant ApplicationRecord)
      t.timestamps                                  # Automated creation of 'created_at' & 'update_at' timestamps
    end
  end
end
