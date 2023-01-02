Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins  'api.transactions.afetiveau.com', 'localhost:3000',  'localhost:4200', 'transactions.afetiveau.com', 'transactions-v2.afetiveau.com'
    resource '*',
             headers: :any,
             expose: %w[access-token expiry token-type uid client],
             methods: [:get, :post, :options, :delete, :put, :patch],
             credentials: true
  end
end