Rails.application.configure do

  config.action_mailer.smtp_settings = {
    address: ENV.fetch("SMTP_HOST"),
    port: ENV.fetch("SMTP_PORT"),
    user_name: ENV.fetch("SMTP_USER"),
    password: ENV.fetch("SMTP_PASSWORD"),
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.action_mailer.default_options = { from: 'transactions@afetiveau.com' }
  config.action_mailer.default_url_options = { host: "api.transactions.afetiveau.com" }
end
