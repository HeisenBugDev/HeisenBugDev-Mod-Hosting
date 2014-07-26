HeisenBugDev.DownloadCardComponent = Ember.Component.extend
  classNames: ['download-card']
  classNameBindings: ['hide']

  setType: ( ->
    return @set('hide', true) unless @get('build')
    self = this
    @get('build').then (build) ->
      self.set('type', " #{HeisenBugDev.helpers.capitalize(build.get('build_state'))}")
  ).observes('build.build_state').on('init')
