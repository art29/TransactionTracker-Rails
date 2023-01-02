Rails.application.configure do
  smtp_credentials = Rails.application.credentials[Rails.env.to_sym][:smtp]

  break if smtp_credentials.nil?

  config.action_mailer.smtp_settings = {
    address: smtp_credentials[:address],
    port: smtp_credentials[:port],
    user_name: smtp_credentials[:username],
    password: smtp_credentials[:password],
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: "transactions.afetiveau.com" }
end
