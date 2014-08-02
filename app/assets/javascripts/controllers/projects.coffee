HeisenBugDev.ProjectsIndexController = Ember.ArrayController.extend HeisenBugDev.PaginatedController,
  paginatedObjectName: 'project'

HeisenBugDev.ProjectsShowController = Ember.ObjectController.extend
  save: ->
    this.get('model').save()