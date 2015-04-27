class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity,
            presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :responders

  after_create :dispatch_responders

  after_update :free_responders

  scope :full_responses, -> { where(full_response: true) }

  def responders_names
    responders.pluck(:name)
  end

  def self.response_summary
    [Emergency.full_responses.count, Emergency.count]
  end

  private

  def dispatch_responders
    Responder.on_duty.order(:type, capacity: :desc).to_a.group_by(&:type).each do |type, responders|
      required_capacity = send(type.downcase + '_severity')
      min_number_of_responders(responders, required_capacity) unless optimal_responder(responders, required_capacity)
    end
  end

  def optimal_responder(responders, required_capacity)
    responder = responders.find { |x| x.capacity == required_capacity }
    return false if responder.nil?
    commit_dispatch [responder.id], true
    true
  end

  def min_number_of_responders(responders, required_capacity)
    responder_ids = []
    responders.each do |x|
      break if required_capacity < 1
      required_capacity -= x.capacity
      responder_ids << x.id
    end
    commit_dispatch responder_ids, required_capacity == 0
  end

  def commit_dispatch(responder_ids, fulfilled)
    return if responder_ids.empty?
    Responder.where(id: responder_ids).update_all(emergency_id: self)
    update(full_response: false) unless fulfilled
  end

  def free_responders
    responders.update_all(emergency_id: nil) unless resolved_at.nil?
  end
end
