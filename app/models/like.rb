class Like < ApplicationRecord
  belongs_to :user                                # 1 'like' is added by 1 given user
  belongs_to :gossip, optional: true              # 1 'like' is linked to 0..1 gossip, 'optional' so can be 'nil'
  belongs_to :comment, optional: true             # XOR to 1..0 comment, 'optional so can be 'nil'
end
