HeisenBugDev.PaginatedRoute = Ember.Mixin.create
  # Return an empty array immediately from the model hook.
  model: ->
    @set "cursor", null
    []

  # Wrapper around fetchPage which needs to be implemented by the route.
  # Keeps track of whether we are currently fetching a page, and saves the cursor
  # returned by the server.
  fetchPageProxy: (cursor) ->
    self = this
    @setCurrent true
    @fetchPage(cursor).then (objects) ->
      self.set "cursor", objects.get("meta.cursor")
      Ember.run.next ->
        self.setCurrent false

      if objects.get("length") is 0
        self.setCanLoadMore false
      else
        self.setCanLoadMore true
      objects

  # Set canLoadMore on the controller while setting it up.
  setupController: (controller, model) ->
    @setCanLoadMore true
    controller.set "canLoadMore", @get("canLoadMore")
    controller.set "cannotLoadMore", !(@get("canLoadMore"))
    controller.set "model", model

  # Set `canLoadMore` on the route and, if possible, on the controller.
  setCanLoadMore: (canLoadMore) ->
    @controller.set('content', @store.all(@controller.get('paginatedObjectName'))) if @controller
    @set "canLoadMore", canLoadMore
    @set "cannotLoadMore", !canLoadMore
    @controller.set "canLoadMore", canLoadMore  if @controller
    @controller.set "cannotLoadMore", !canLoadMore  if @controller

  setCurrent: (current) ->
    @set "currentlyFetchingPage", current
    @controller.set "currentlyFetchingPage", current if @controller

  fetchPage: ->
    controller = @get('controller')
    page = controller.get('page')
    controller.set('page', controller.get('page') + 1)
    @store.find controller.get('paginatedObjectName'), page: page

  actions:
    loadNextPage: ->
      that = this
      if @get("canLoadMore") and not @get("currentlyFetchingPage")
        @fetchPageProxy(@get("cursor")).then (objects) ->
          that.controller.get("content").addObjects objects
