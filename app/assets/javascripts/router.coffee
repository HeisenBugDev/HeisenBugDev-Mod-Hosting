# For more information see: http://emberjs.com/guides/routing/
HeisenBugDev.Router.reopen
  location: 'history'

HeisenBugDev.Router.map ()->
  @resource 'users', ->
    @route 'show', { path: '/:user_id' }
  @route "home", path: '/'
  @route 'missing', path: '*:'
  @resource 'projects', ->
    @route 'show', { path:   ':project_id' }
    @route 'builds', { path: ':project_id/builds' }

HeisenBugDev.MissingRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'missing'
