class User < ApplicationRecord
    validates :username, uniqueness:{ case_sensitive: false }, length:{minimum: 6, maximum:30}
    has_secure_password
    has_one_attached :avatar
    has_many :messages
    
end
