class Responder < ActiveRecord::Base
  validates :type, presence: true
  validates :name, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0, lesser_than: 6 }
end
