HeisenBugDev.ProjectsRoute = Ember.Route.extend()

HeisenBugDev.ProjectsIndexRoute = Ember.Route.extend HeisenBugDev.PaginatedRoute
HeisenBugDev.ProjectsShowRoute = Ember.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

  afterModel: (project) ->
    Ember.RSVP.all [
      project.get('latestReleaseBuild')
      project.get('latestBetaBuild')
      project.get('latestNormalBuild')
    ]

HeisenBugDev.ProjectsBuildsRoute = Ember.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

  afterModel: (project) ->
    Em.RSVP.all [project.get('builds'), project.get('builds').get('version')]

HeisenBugDev.ProjectsNewBuildRoute = Ember.Route.extend
  setupController: (controller, project) ->
    build = @store.createRecord('build', {commit: '12kjsdf', project: project})
    controller.set('model', build)

  serialize: (model) ->
    project_id: model.get('slug')
