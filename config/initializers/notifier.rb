# -*- encoding : utf-8 -*-
unless Rails.env.development?
Sz2019::Application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[sz2019] ",
    :sender_address => %{"sz2019" <sz2019@sz2019.beziliska.cz>},
    :exception_recipients => %w{moskyt@rozhled.cz},
    :sections => %w{request session environment backtrace},
  }
end
