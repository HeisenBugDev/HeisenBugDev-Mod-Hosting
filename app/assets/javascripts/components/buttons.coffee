HeisenBugDev.DownloadButtonComponent = Ember.Component.extend
  tagName: 'a'
  attributeBindings: ['href']
  classNameBindings: ['button_class', 'textCenter']

  bootstrap: (->
    @set('isLoading', true)
    this.send('sethref')
  ).on('init')

  setupBuild: (->
    self = this

    unless @get('build')?
      @set('button_class', 'disabled-button') unless @get('project')?
      @set('textCenter', true)
      return

    @get('build').then (build) ->
      switch build.get('build_state')
        when 'release'
          self.set('button_class', 'release-button')
          self.set('label', 'R')
        when 'beta'
          self.set('button_class', 'beta-button')
          self.set('label', 'B')
        when 'bugged'
          self.set('button_class', 'bugged-button')
          self.set('label', 'G')
        when 'normal'
          self.set('button_class', 'normal-button')
          self.set('textCenter', true)
        else
          self.set('textCenter', true)
          self.set('button_class', 'button')
  ).on('init')

  setupProject: (->
    return unless @get('project')?
    self = this
    @set('button_class', 'button')
    @set('href', @get('project').get(@get('project_attribute')))
  ).on('init')

  actions:
    sethref: (->
      @set('isLoading', false)
      return unless @get('build')?
      build_attribute = @get('build_attribute')
      self = this
      @get('build').then (build) ->
        self.set('href', build.get(build_attribute))
    )

HeisenBugDev.LoadingSpinnerComponent = Ember.Component.extend()