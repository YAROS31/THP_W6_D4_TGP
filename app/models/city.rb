class City < ApplicationRecord
  has_many :users                   # Can be linked to 0..N users
end
