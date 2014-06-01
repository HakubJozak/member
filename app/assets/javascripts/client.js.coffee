#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self

#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes
#= require ./router

# for more details see: http://emberjs.com/guides/application/



window.Mana = Ember.Application.create {
  ready: ->
    window.slot = []
    window.view = Mana.SlotView.create
      content: window.slot
    window.view.appendTo('body')
}

Mana.ApplicationAdapter = DS.FixtureAdapter
