class UserMailer < ActionMailer::Base
  default from: "shakti@grepruby.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://0.0.0.0:3000/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site').deliver
  end
end
