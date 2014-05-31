# For more information see: http://emberjs.com/guides/routing/
HeisenBugDev.Router.reopen
  location: 'history'

HeisenBugDev.Router.map ()->
  @route "home"
  @resource 'users', path: '/users', ->
    @route 'edit', path: 'edit'
  @route 'user', path: '/users/:user_id'
  @route 'omniauth_callbacks', path: '/api/users/auth/:provider/callback'
  @route 'missing', path: '*:'

HeisenBugDev.MissingRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'missing'

HeisenBugDev.OmniAuthCallbacks = Ember.Route.extend
  redirect: ->
    @transitionTo 'home'
