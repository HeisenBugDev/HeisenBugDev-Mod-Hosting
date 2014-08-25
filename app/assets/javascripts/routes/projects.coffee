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
  # No, this doesn't work :|
  setupController: (controller, model) ->
    build = @store.createRecord('build', {commit: '12kjsdf'})
    model.get('builds').then (builds) ->
      builds.addObject(build)
      controller.set('model', build)
      # Ember.run.scheduleOnce 'afterRender', this, ->
        # Ember.$('body').removeClass('loading')

  serialize: (model) ->
    project_id: model.get('slug')

  afterModel: (model) ->
    Em.RSVP.all([model.get('project')])

  # model: (params) ->
    # Ember.$('body').addClass('loading')
    # @store.find('project', params.project_id)
