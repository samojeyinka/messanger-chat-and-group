class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  after_create_commit { broadcast_append_to self.group }
end
