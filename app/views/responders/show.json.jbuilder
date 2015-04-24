json.set! :responder do
  json.extract! @responder, :type, :name, :capacity, :on_duty, :emergency_code
end
