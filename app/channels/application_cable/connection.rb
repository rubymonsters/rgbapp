module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :admin
    
    def connect 
      find_admin
    end
    
    private
    
    def find_admin
      self.admin = User.find_by(admin: true, remember_token: cookies[:remember_token]) || reject_unauthorized_connection
    end 

  end
end
