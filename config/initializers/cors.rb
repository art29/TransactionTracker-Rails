Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins  'localhost:3000',  'localhost:4200', ENV.fetch("API_URL"), ENV.fetch("FRONT_END_URL")
    resource '*',
             headers: :any,
             expose: %w[access-token expiry token-type uid client],
             methods: [:get, :post, :options, :delete, :put, :patch],
             credentials: true
  end
end