HeisenBugDev.ProjectsIndexController = Ember.ArrayController.extend HeisenBugDev.PaginatedController,
  paginatedObjectName: 'project'

HeisenBugDev.ProjectsShowController = Ember.ObjectController.extend Ember.Validations.Mixin,
  validations:
    description:
      presence: true
  actions:
    save: ->
      @get('model').save().then((->), (->))

HeisenBugDev.ProjectsNewBuildController = Ember.ObjectController.extend Ember.Validations.Mixin,
  validations:
    minecraft_version:
      presence: true
      inclusion:
        # TODO this
        in: [
          '1.6.1'
          '1.6.2'
          '1.6.4'
          '1.7.2'
          '1.7.10'
        ]
        message: "That version is not supported"
    commit:
      presence: true
      format:
        with: /^([a-f0-9]*)$/
        message: "That is not a valid SHA"
      length:
        'is': 40
        messages:
          wrongLength: "The commit must be a 40 character SHA"
    branch:
      presence: true
      format:
        with: /^[\x00-\x1F\x21-\x7F]+$/
        message: "No unicode or spaces!"

  actions:
    submit: ->
      @set('isSavingBuild', true)
      self = this
      @get('model').save().then((->
        self.set('isSavingBuild', false)
        self.set('showGenericError', false)
        self.set('showArtifactUpload', true)
      ), (->
        self.set('isSavingBuild', false)
        self.set('showGenericError', true)
      ))
