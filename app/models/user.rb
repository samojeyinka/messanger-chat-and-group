class User < ApplicationRecord
    validates :username, uniqueness:{ case_sensitive: false }, length:{minimum: 6, maximum:30}
    has_secure_password
    has_one_attached :avatar
  
    # def self.all_except(user)
    #     where.not(id: user.id)
    #   end
    scope :all_except, ->(user) { where.not(id: user) }
      after_create_commit { broadcast_append_to "users" }
      has_many :messages
end
