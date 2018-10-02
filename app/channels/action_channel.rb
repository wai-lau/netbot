class MovesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'moves'
  end
end 
