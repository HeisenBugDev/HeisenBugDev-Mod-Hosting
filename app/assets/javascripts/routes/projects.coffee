HeisenBugDev.ProjectsRoute = Em.Route.extend()

HeisenBugDev.ProjectsIndexRoute = Em.Route.extend HeisenBugDev.PaginatedRoute
HeisenBugDev.ProjectsShowRoute = Em.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

HeisenBugDev.ProjectsBuildsRoute = Em.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'