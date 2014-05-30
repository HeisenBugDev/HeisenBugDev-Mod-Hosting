# For more information see: http://emberjs.com/guides/routing/

HeisenBugDev.Router.map ()->
  @route "home"
  @resource 'users', path: '/users', ->
    @route 'edit', path: 'edit'
  @route 'user', path: '/users/:user_id'

  @route 'sign-in'
  @route 'oauth_callbacks', path: '/auth/:provider/callback'
  @route 'missing', path: '*:'

HeisenBugDev.OauthCallbacksRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'application'

HeisenBugDev.MissingRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'missing'
