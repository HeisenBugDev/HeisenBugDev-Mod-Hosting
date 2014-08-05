HeisenBugDev.ProjectsRoute = Ember.Route.extend()

HeisenBugDev.ProjectsIndexRoute = Ember.Route.extend HeisenBugDev.PaginatedRoute
HeisenBugDev.ProjectsShowRoute = Ember.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

HeisenBugDev.ProjectsBuildsRoute = Ember.Route.extend
  serialize: (model) ->
    project_id: model.get 'slug'

HeisenBugDev.ProjectsNewBuildRoute = Ember.Route.extend
  setupController: ->
    self = this
    @store.find('project', 1).then (project) ->
      build = self.store.createRecord('build', {commit: '12kjsdf'})
      project.get('builds').then (builds) ->
        builds.addObject(build)
        self.get('controller').set('model', build)

  serialize: (model) ->
    project_id: model.get 'slug'
