HeisenBugDev.DownloadCardComponent = Ember.Component.extend
  classNames: ['download-card']
  changelog: 'blajdskf'

  setType: ( ->
    self = this
    @get('build').then (build) ->
      self.set('type', " #{HeisenBugDev.helpers.capitalize(build.get('build_state'))}")
  ).observes('build.build_state').on('init')
