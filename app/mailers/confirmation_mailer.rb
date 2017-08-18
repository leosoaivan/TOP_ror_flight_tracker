class ConfirmationMailer < ApplicationMailer
  default from: 'flight_booker@example.com'

  def confirmation_email(passenger_hash)
    @passenger = passenger_hash
    mail(to: @passenger[:email], subject: 'CONFIRMATION: Congrats on booking your flight!')
  end
end

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