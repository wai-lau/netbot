class Game < ApplicationRecord
  belongs_to :user
  serialize :state
end
