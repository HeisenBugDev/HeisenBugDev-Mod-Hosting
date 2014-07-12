HeisenBugDev.UsersIndexController = Ember.ArrayController.extend
  page: 1
  paginatedObjectName: 'user'
  filterName: '' # This sets a default value

  filteredUsers: Ember.computed((->
    controller = this
    @store.filter('user', (user) ->
      return (user.get('nameLowerCase').indexOf(controller.get('filterName')?.toLowerCase()) == 0))
  )).property('filterName')
