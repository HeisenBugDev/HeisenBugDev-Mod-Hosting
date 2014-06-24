HeisenBugDev.UsersRoute = Em.Route.extend
  authRedirectable: true

HeisenBugDev.UsersIndexRoute = Em.Route.extend
  model: ->
    @store.findQuery 'user'

HeisenBugDev.UsersShowRoute = Em.Route.extend
  serialize: (model) ->
    user_id: model.get 'param'