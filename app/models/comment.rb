class Comment < ApplicationRecord
  belongs_to :user                        # Link with 1 user
  belongs_to :gossip, optional: true      # Link to 0..1 gossip ('optional' enables this link to be null), "optional" so can be 'nil'
  belongs_to :comment, optional: true     # Link to 1..0 comment ('optional' enables this link to be null), "optional" so can be 'nil'
end
