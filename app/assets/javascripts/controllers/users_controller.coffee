HeisenBugDev.UsersIndexController = Ember.ArrayController.extend
  page: 1

HeisenBugDev.UsersIndexView = Ember.View.extend
  didInsertElement: ->
    $(window).on('scroll', $.proxy(this.didScroll, this));

  willDestroyElement: ->
    $(window).off('scroll', $.proxy(this.didScroll, this));

  didScroll: ->
    if this.isScrolledToBottom()
      this.get('controller').send('getMore')

  isScrolledToBottom: ->
    # distanceToViewportTop = $(document).height() - $(window).height()
    # viewPortTop = $(document).scrollTop()
    return true if $('.load-more').is(":visible")
    # return false if viewPortTop == 0
    # return (viewPortTop - distanceToViewportTop == 0)
