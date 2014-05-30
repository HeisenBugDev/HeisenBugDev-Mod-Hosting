HeisenBugDev.UsersRoute = Ember.Route.extend
  model: ->
    @store.find 'user'

HeisenBugDev.UserRoute = Ember.Route.extend
  setUpController: (controller, user)->
    controller.set('model', user)