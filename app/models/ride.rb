class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    # accounts for the user not having enough tickets and/or not tall enough
    if missing_tickets && not_tall_enough
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."  
    elsif missing_tickets
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."  
    elsif not_tall_enough
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      go_on_ride
      "Thanks for riding the #{self.attraction.name}!"
    end
  end

  def missing_tickets
    self.user.tickets < self.attraction.tickets
  end

  def not_tall_enough
    self.user.height < self.attraction.min_height
  end
  
  def go_on_ride
    ride_user = self.user
    ride_user.update(
      # updates ticket #
      tickets: (ride_user.tickets - self.attraction.tickets),
      # updates user's nausea
      nausea: (ride_user.nausea + self.attraction.nausea_rating),
      # updates user's happiness
      happiness: (ride_user.happiness + self.attraction.happiness_rating)
    )
  end
end

