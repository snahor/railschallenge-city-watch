json.set! :emergency do
  json.extract! @emergency, :id, :code, :fire_severity, :police_severity, :medical_severity, :full_response, :created_at, :updated_at, :resolved_at
end
