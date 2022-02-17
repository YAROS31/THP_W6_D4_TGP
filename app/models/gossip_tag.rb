class GossipTag < ApplicationRecord
  belongs_to :gossip                                # Link to 1 'gossip' (to enable the gossip (N) <=> (N) tag relation)
  belongs_to :tag                                   # Link to 1 'tag' (cf. above)
end
