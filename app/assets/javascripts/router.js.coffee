# For more information see: http://emberjs.com/guides/routing/

HeisenBugDev.Router.map ()->
  @route "home"

HeisenBugDev.IndexRoute = Ember.Route.extend
  beforeModel: (transition) ->
    @transitionTo 'home'
