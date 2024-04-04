class Message < ApplicationRecord
  before_create :confirm_participant

  belongs_to :user
  belongs_to :group
  after_create_commit { broadcast_append_to self.group }



def confirm_participant
  if self.group.is_private
    is_participant = Participant.where(user_id: self.user.id, group_id: self.group.id).first
    throw :abort unless is_participant
  end
end

end
