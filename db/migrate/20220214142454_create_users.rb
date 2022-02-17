class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name                  # First name of the user
      t.string :last_name                   # Family name of the user
      t.string :nickname                    # TO DO: should it be made unique? Nickname of the user as shown in the application / gossips
      t.string :gender                      # TO DO : see if a simple "M/F/U" choice would do the trick or a dedicated reference table / model would be required
      t.integer :age                        # TO DO: should be computed from 'birthdate'
      t.date :birthdate                     # Birthdate used to compute 'age' and fill 'is_adult' accordingly
      t.boolean :is_adult                   # TO DO: to be computed from age / birthdate. 'true' if age >=18 (or 21?), false elseway
      t.belongs_to :city , index: true      # 1 user lives in 1 city only
      t.timestamps                          # Automated creation of 'created_at' & 'update_at' timestamps   
     end
  end
end
