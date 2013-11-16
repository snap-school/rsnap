json.array!(@programs) do |program|
  json.extract! program, :source_code
  json.url program_url(program, format: :json)
end
