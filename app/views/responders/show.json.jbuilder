json.set! :responder do
  json.extract! @responder, :type, :name, :capacity, :on_duty
  json.set! :emergency_code, nil
end
