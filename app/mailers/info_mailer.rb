class InfoMailer < ApplicationMailer

  def initial_links_email(team)
    @team = team
    
    mail(
      to: @team.initial_emails,
      from: "moskyt@rozhled.cz",
      subject: "SZ 2019 / krajské kolo Praha / přístupy na web pro závodníky a doprovody -- hlídka #{@team.name} -- #{@team.district}"
    )
  end
  
end
