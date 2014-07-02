#= require jquery
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require handlebars
#= require ember
#= require ember-data
#= require_self

#= require ./mixins/jquery_ui_base
#= require_tree ./mixins

#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes
#= require ./router


window.Mana = Ember.Application.create {
  rootElement: '#ember-app'
  ready: ->
    console.info 'Mana started.'
}


Mana.WebSocketAdapter = DS.ActiveModelAdapter.extend({

  init: ->
    # TODO: Mana.inject('data-adapter', 'store', 'store:main')
    @store = Mana.__container__.lookup('store:main')
    @ws = new WebSocket("ws://localhost:3000/")

    # callbacks
    @ws.onopen = ->
      console.log "Websocket connected"

    @ws.onclose = ->
      console.log "Websocket closed"

    @ws.onmessage = (msg) =>
      json =  JSON.parse(msg.data)
      if json.card
        @store.update('card',json.card)
      else if json.slot
        @store.update('slot',json.slot)
      else if json.player
        @store.update('player',json.player)
      else if json.message
        @store.update('message',json.message)
      else
        console.info "unknown type: #{json}"

  createRecord: (store,type,record) ->
    debugger
    if type == Mana.Message
      attrs = {}
      attrs['message'] =  record.toJSON(includeId: true)
    # fake promise as it happens synchronously :/
      new Ember.RSVP.Promise((resolve, reject) =>
        @ws.send(JSON.stringify(attrs))
        resolve(null)
      )


  updateRecord: (store,type,record) ->
    attrs = {}
    if type == Mana.Card
      attrs['card'] =  record.toJSON(includeId: true)
    else if type == Mana.Slot
      attrs['slot'] = record.toJSON(includeId: true)
    else if type == Mana.Player
      attrs['player'] = record.toJSON(includeId: true)
    else
      throw "Don't know how to send #{type} via Websocket"

    # fake promise as it happens synchronously :/
    new Ember.RSVP.Promise((resolve, reject) =>
      @ws.send(JSON.stringify(attrs))
      resolve(null)
    )
})



Mana.ApplicationAdapter = Mana.WebSocketAdapter
