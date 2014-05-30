HeisenBugDev.IndexRoute = Ember.Route.extend
  beforeModel: (transition) ->
    @transitionTo 'home'
