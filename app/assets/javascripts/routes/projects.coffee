HeisenBugDev.ProjectsRoute = Ember.Route.extend()

HeisenBugDev.ProjectsIndexRoute = Ember.Route.extend HeisenBugDev.PaginatedRoute
HeisenBugDev.ProjectsShowRoute = Ember.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

HeisenBugDev.ProjectsBuildsRoute = Ember.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

HeisenBugDev.ProjectsNewBuildRoute = Ember.Route.extend
  setupController: (controller, model) ->
    build = @store.createRecord('build', {commit: '12kjsdf'})
    model.get('builds').then (builds) ->
      builds.addObject(build)
      controller.set('model', build)
      Ember.run.scheduleOnce 'afterRender', this, ->
        Ember.$('body').removeClass('loading')

  serialize: (model) ->
    project_id: model.get('slug')

  model: (params) ->
    Ember.$('body').addClass('loading')
    @store.find('project', params.project_id)
