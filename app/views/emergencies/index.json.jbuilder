json.set! :emergencies do
  json.array!(@emergencies) do |emergency|
    json.extract! emergency, :code, :fire_severity, :police_severity, :medical_severity, :full_response
  end
end
json.set! :full_responses, Emergency.response_summary
