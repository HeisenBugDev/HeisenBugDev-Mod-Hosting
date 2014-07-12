HeisenBugDev.UsersRoute = Em.Route.extend
  authRedirectable: true

HeisenBugDev.UsersIndexRoute = Em.Route.extend HeisenBugDev.PaginatedRoute,
  fetchPage: ->
    controller = @get('controller')
    page = controller.get('page')
    controller.set('page', controller.get('page') + 1)
    @store.find controller.get('paginatedObjectName'), page: page

HeisenBugDev.UsersShowRoute = Em.Route.extend
  serialize: (model) ->
    user_id: model.get 'name'