HeisenBugDev.ApplicationController = Ember.Controller.extend
  signedInUser: (->
    @store.find 'user', localStorage['currentUser']
  ).property('HeisenBugDev.currentUser')

  userSignedIn: (->
    localStorage['currentUser']?
  ).property('HeisenBugDev.currentUser')

  actions:
    signOut: ->
      console.log "Sign Out"
      delete localStorage['currentUser']
      HeisenBugDev.set 'currentUser', `undefined`