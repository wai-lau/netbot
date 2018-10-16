class Game < ApplicationRecord
  has_one :grid
  belongs_to :user
  serialize :state
end
