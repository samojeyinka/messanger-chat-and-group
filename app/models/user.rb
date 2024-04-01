class User < ApplicationRecord
    validates :username, uniqueness:{ case_sensitive: false }, length:{minimum: 6, maximum:30}
    has_secure_password

    
 

end