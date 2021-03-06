Mana.PackView = Ember.View.extend Mana.DroppableForCard, {
  tagName: 'div'
  classNames: [ 'pile-container' ]
  templateName: 'pack'
  backImage: window.image_path('back.jpg')
  emptyImage: window.image_path('empty.png')


  # jQuery UI
  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  tolerance: 'pointer'

  init: ->
    @_super()
    @get('holder').addObserver 'top', =>
      @rerender()
}
