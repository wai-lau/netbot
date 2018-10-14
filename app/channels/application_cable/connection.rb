module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def disconnect
      if current_user
        games = Game.where(user_id: current_user.id)
        game = games.last if games
        if game
          game.state = request.session["grid_state"]
          game.save
        end
      end
    end

    private

    def current_user
      if request.session["user_id"]
        User.find_by(id: request.session["user_id"])
      end
    end
  end
end
