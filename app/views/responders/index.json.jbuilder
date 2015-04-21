json.set! :responders do
  json.array!(@responders) do |responder|
    json.extract! responder, :type, :name, :capacity, :on_duty
    json.set! :emergency_code, nil
  end
end
