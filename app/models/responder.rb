class Responder < ActiveRecord::Base
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, inclusion: { in: 1..5 }

  self.inheritance_column = 'not_sti'
end
