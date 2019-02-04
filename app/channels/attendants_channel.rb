class AttendantsChannel < ApplicationCable::Channel

def subscribed
  stream_from 'attendants'
end

end
