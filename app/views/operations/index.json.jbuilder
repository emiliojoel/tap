json.array!(@operations) do |operation|
  json.extract! operation, :id, :event, :api_version, :account_id, :signature, :data
  json.url operation_url(operation, format: :json)
end
