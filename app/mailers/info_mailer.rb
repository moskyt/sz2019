class InfoMailer < ApplicationMailer

  def initial_links_email(event_registration)
    @event_registration = event_registration
    @event = event_registration.event
    
    mail(
      to: RAMACH_EMAIL,
      subject: "Pražská MTBO liga -- objednávka mapníku na trénink #{@event.date.strftime("%d. %m. %Y")} (#{@event})"
    )
  end
  
end
