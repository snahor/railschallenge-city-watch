class Responder < ActiveRecord::Base
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, inclusion: { in: 1..5 }

  self.inheritance_column = 'not_sti'

  belongs_to :emergency

  scope :available, -> { where(emergency_id: nil) }
  scope :on_duty, -> { where(on_duty: true) }
  scope :capacity_sum, -> { group('type').sum('capacity') }

  def self.capacity_summary
    data = {}
    available = Responder.available.capacity_sum
    on_duty = Responder.on_duty.capacity_sum
    available_on_duty = Responder.available.on_duty.capacity_sum
    Responder.capacity_sum.map do |k, v|
      data[k] = [v, available[k] || 0, on_duty[k] || 0, available_on_duty[k] || 0]
    end
    data
  end

  def emergency_code
    emergency.code unless emergency.nil?
  end
end
