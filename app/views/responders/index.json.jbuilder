json.set! :responders do
  json.array!(@responders) do |responder|
    json.extract! responder, :type, :name, :capacity, :on_duty, :emergency_code
  end
end
