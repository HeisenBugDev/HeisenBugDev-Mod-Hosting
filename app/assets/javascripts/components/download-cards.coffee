HeisenBugDev.DownloadCardComponent = Ember.Component.extend
  classNames: ['download-card']

  setType: ( ->
    self = this
    @get('build').then (build) ->
      self.set('type', " #{HeisenBugDev.helpers.capitalize(build.get('build_state'))}")
  ).observes('build.build_state').on('init')
