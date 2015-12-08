MANDRILL_API_KEY ='vJDL-XahxGx7dadEG_DDoQ'
ActionMailer::Base.smtp_settings = {
    address: 'smtp.mandrillapp.com',
    port: 587,
    enable_starttls_auto: true,
    user_name: 'v.volontsevich@mobidev.biz',
    password: MANDRILL_API_KEY,
    authentication: 'login'
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'