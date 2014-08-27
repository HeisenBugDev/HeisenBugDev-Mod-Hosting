HeisenBugDev.UsersRoute = Em.Route.extend()

HeisenBugDev.UsersIndexRoute = Em.Route.extend HeisenBugDev.PaginatedRoute

HeisenBugDev.UsersShowRoute = Em.Route.extend
  serialize: (model) ->
    user_id: model.get 'slug'