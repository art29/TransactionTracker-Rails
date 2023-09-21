Rails.application.configure do

  config.action_mailer.smtp_settings = {
    address: ENV.fetch("SMTP_HOST"),
    port: ENV.fetch("SMTP_PORT"),
    user_name: ENV.fetch("SMTP_USER"),
    password: ENV.fetch("SMTP_PASSWORD"),
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.action_mailer.default_options = { from: ENV.fetch("SMTP_FROM") }
  config.action_mailer.default_url_options = { host: ENV.fetch("API_URL") }
end
