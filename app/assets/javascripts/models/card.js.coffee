Mana.Card = DS.Model.extend
  slot_id: DS.attr 'number'
  position: DS.attr 'number'

  name: DS.attr 'string'
  frontside: DS.attr 'string'
  backside: DS.attr 'string'

  power: DS.attr 'number'
  toughness: DS.attr 'number'
  counters: DS.attr 'number'

  covered: DS.attr 'boolean'
  tapped: DS.attr 'boolean'
  flipped: DS.attr 'boolean'

  slot: DS.belongsTo('slot')
  # game: DS.belongsTo('game')

  power_and_toughness: (->
    [ p,t ] = [ @get('power'), @get('toughness') ]
    "#{p || '-'}/#{t || '-'}" if p or t
  ).property('power','toughness')

  flip: ->
    if @get('backside')
      @toggleProperty 'flipped'

  tap: ->
    @toggleProperty 'tapped'

  toggleCovered: ->
    @toggleProperty 'covered'

  moveTo: (new_slot) ->
    old_slot = @get('slot')
    old_slot.get('cards').removeObject(this)
    new_slot.get('cards').pushObject(this)
    @set 'position', new_slot.next_position() # new_slot.get('bottom.position') - 1
    @set 'slot', new_slot
    new_slot.after_drop(this)

  statsChanged: ( ->
    if @get('isDirty')
      console.debug "Saving card #{@get('id')}"
      Ember.run.once this, 'save'
  ).observes('counters','power','toughness','tapped','covered','flipped','slot_id')
