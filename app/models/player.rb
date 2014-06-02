class Player < ActiveRecord::Base

  serialize :settings
  belongs_to :user

  attr_accessor :prepared_deck


  after_create do
    # TODO: compute order automatically or too much pain?
    # order = 0

    # Deck.build_cards(deck.mainboard) do |card|
    #   card.player = self
    #   card.game = game
    #   card.order = (order += 1)
    #   card.collection_id = "library-#{self.id}"
    #   card.save!
    # end
  end

  after_initialize do
    self.settings ||= {}
    self.prepared_deck = 'ADHOC'
    self.mainboard = '10;Forest'

    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from cookie
      self.name ||= "Guest"
    end
  end

end