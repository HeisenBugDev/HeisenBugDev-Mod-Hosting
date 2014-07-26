HeisenBugDev.DownloadButtonComponent = Ember.Component.extend
  tagName: 'a'
  attributeBindings: ['href']
  classNameBindings: ['button_class', 'textCenter']

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
  ).observes('build.build_state').on('init')

  setupProject: (->
    return unless @get('project')?
    self = this
    @set('button_class', 'button')
    @set('href', @get('project').get('main_download'))
  ).observes('project.main_download').on('init')

  sethref: (->
    return unless @get('build')?
    self = this
    @get('build').then (build) ->
      self.set('href', build.get('main_download'))
  ).observes('build.main_download').on('init')
