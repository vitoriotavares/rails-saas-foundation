require "test_helper"

describe UserMailer do
  it "creates welcome_email email" do
    mail = UserMailer.welcome_email
    mail.subject.must_equal "Welcome email"
    mail.to.must_equal ["to@example.org"]
    mail.from.must_equal ["from@example.com"]
    mail.body.encoded.must_equal "Hi"
  end

end
