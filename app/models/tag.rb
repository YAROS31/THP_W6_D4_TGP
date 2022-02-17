class Tag < ApplicationRecord
  has_many :gossip_tags, dependent: :destroy          # 1 tag has 0..N links with the 'gossip_tags' joint table
  has_many :gossips, through: :gossip_tags            # Hence 1 'tag' can have a view on 0..N related 'gossips', via the joint table
end
