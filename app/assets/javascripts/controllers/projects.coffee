HeisenBugDev.ProjectsIndexController = Ember.ArrayController.extend HeisenBugDev.PaginatedController,
  paginatedObjectName: 'project'

HeisenBugDev.ProjectsShowController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save().then((->), (->))

HeisenBugDev.ProjectsNewBuildController = Ember.ObjectController.extend Ember.Validations.Mixin,
  validations:
    minecraft_version:
      presence: true
    commit:
      presence: true
    branch:
      presence: true

  actions:
    submit: ->
      @get('model').save().then((->), (->))
