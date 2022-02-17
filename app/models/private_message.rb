class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: "User", optional: true                       # 1 message has 1 sender (user) only
  belongs_to :recipient, class_name: "User", optional: true                    # 1 message has 1 recipient (user) only
  belongs_to :previous_message, class_name: "PrivateMessage", optional: true   # 1 message is linked to 0..1 prior message (discussion)
end
