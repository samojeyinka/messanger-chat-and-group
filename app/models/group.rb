class Group < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    scope :public_groups, -> { where(is_private: false) }
    after_create_commit {broadcast_append_to "groups"}
    has_many :messages
    has_one_attached :coverPhoto
    has_many :participants, dependent: :destroy
    after_create_commit { broadcast_if_public }


    def broadcast_if_public
        broadcast_append_to "groups" unless self.is_private
      end
      
      def self.create_private_group(users, group_name)
        single_group = Group.create(name: group_name, is_private: true)
        users.each do |user|
          Participant.create(user_id: user.id, group_id: single_group.id )
        end
        single_group
      end
end
