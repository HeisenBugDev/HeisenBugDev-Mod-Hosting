# For more information see: http://emberjs.com/guides/routing/
# HeisenBugDev.Router.reopen
#   location: 'history'

HeisenBugDev.Router.map ()->
  @route "home"
  @resource 'users', path: '/users', ->
    @route 'edit', path: 'edit'
  @route 'user', path: '/users/:user_id'

  @route 'sign-in'
  @route 'sign-out', path: '/users/sign_out/:user_id'
  @route 'oauth_callbacks', path: '/auth/:provider/callback'
  @route 'missing', path: '*:'

HeisenBugDev.OauthCallbacksRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'application'

HeisenBugDev.MissingRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'missing'
