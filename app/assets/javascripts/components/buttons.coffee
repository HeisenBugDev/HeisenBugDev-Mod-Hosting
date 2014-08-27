HeisenBugDev.DownloadButtonComponent = Ember.Component.extend
  tagName: 'a'
  attributeBindings: ['href']
  classNameBindings: ['button_class', 'textCenter']

  setupBuild: (->
    self = this

    unless @get('build')?
      if !@get('project') || !@get('project').get('main_download')
        @set('button_class', 'disabled-button button')
      @set('textCenter', true)
      return

    build = @get('build')
    unless build.then
      @send('switchData')

    build.then? (build) ->
      self.send('switchData')

  ).observes('build.build_state').on('init')

  setupProject: (->
    return unless @get('project')?
    self = this
    main_dl = @get('project').get('main_download')
    if main_dl
      @set('button_class', 'button')
    else
      @set('button_class', 'disabled-button button')

    @set('href', main_dl || null)
  ).observes('project.main_download').on('init')

  sethref: (->
    return unless @get('build')?
    self = this
    build = @get('build')
    unless build.then
      self.set('href', build.get('main_download') || null)

    build.then? (build) ->
      self.set('href', build.get('main_download') || null)
  ).observes('build.main_download').on('init')

  actions:
    switchData: ->
      switch @get('build').get('build_state')
        when 'release'
          @set('button_class', 'release-button')
          @set('label', 'R')
        when 'beta'
          @set('button_class', 'beta-button')
          @set('label', 'B')
        when 'bugged'
          @set('button_class', 'bugged-button')
          @set('label', 'G')
        when 'normal'
          @set('button_class', 'normal-button')
          @set('textCenter', true)
          @set('label', null)
        else
          @set('textCenter', true)
          @set('button_class', 'button')
          @set('label', null)

      unless @get('build').get('main_download')
        @set('button_class', 'disabled-button')