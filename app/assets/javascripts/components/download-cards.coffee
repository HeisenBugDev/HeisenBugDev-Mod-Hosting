HeisenBugDev.DownloadCardComponent = Ember.Component.extend
  classNames: ['download-card']
  classNameBindings: ['hide']

  setType: ( ->
    return @set('hide', true) unless @get('build')
    self = this
    build = @get('build')

    unless build.then
      build.set('hide', false)
      self.set('type', " #{HeisenBugDev.helpers.capitalize(build.get('build_state'))}") unless @get('noState') == true

    build.then? (build) ->
      self.set('hide', false)
      self.set('type', " #{HeisenBugDev.helpers.capitalize(build.get('build_state'))}") unless self.get('noState') == true

      if self.get('noState') != true
        self.set('titleText', "Latest #{self.get('type')}")

    if @get('noState') != true
      @set('titleText', "Latest #{@get('type')}")
  ).observes('build.build_state').on('init')
