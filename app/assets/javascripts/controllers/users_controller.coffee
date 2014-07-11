HeisenBugDev.UsersIndexController = Ember.ArrayController.extend
  page: 1
  paginatedObjectName: 'user'

HeisenBugDev.PaginatedView = Ember.Mixin.create
  checkLoadMore: ->
    if @isElementInViewport($('.load-more'))
      @get('controller').send('loadNextPage')

  didInsertElement: ->
    @checkLoadMore()
    $(window).on 'DOMContentLoaded load resize scroll', $.proxy(@checkLoadMore, this)

  willDestroyElement: ->
    $(window).off 'DOMContentLoaded load resize scroll', $.proxy(@checkLoadMore, this)

  isElementInViewport: (el) ->
    el = el[0]  if el instanceof jQuery
    return unless el
    rect = el.getBoundingClientRect()
    rect.top >= 0 and rect.left >= 0 and rect.bottom <= (window.innerHeight or document.documentElement.clientHeight) and rect.right <= (window.innerWidth or document.documentElement.clientWidth)

HeisenBugDev.UsersIndexView = Ember.View.extend HeisenBugDev.PaginatedView
