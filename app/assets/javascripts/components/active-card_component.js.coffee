# for more details see: http://emberjs.com/guides/components/

Mana.ActiveCardComponent = Ember.Component.extend({
  click: (event) ->
    card = @get('card')
    card.set('tapped', !card.get('tapped'))
})
