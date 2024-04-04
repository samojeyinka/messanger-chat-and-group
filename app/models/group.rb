class Group < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    scope :public_groups, -> { where(is_private: false) }
    after_create_commit {broadcast_append_to "groups"}
    has_many :messages
end
