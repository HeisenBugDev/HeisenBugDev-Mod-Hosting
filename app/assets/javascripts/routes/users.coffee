HeisenBugDev.UsersRoute = Em.Route.extend
  authRedirectable: true

HeisenBugDev.UsersIndexRoute = Em.Route.extend
  model: ->
    @store.findQuery 'user'
  actions:
    getMore: ->
      controller = this.get('controller')
      return if controller.get('loadingMore')
      controller.set('loadingMore', true)
      nextPage = controller.get('page') + 1
      perPage = controller.get('perPage')
      # items = this.send('fetchPage', nextPage, perPage)
      items = Em.A([])
      firstIndex = (nextPage - 1) * perPage
      lastIndex = nextPage * perPage

      # i = firstIndex
      # while i < lastIndex
      #   items.pushObject(name: "" + i)
      #   i++
      console.log nextPage
      this.set('model', @store.findQuery('user', {page: nextPage}))
      controller.set('loadingMore', false)
      controller.set('page', nextPage)
      # controller.pushObjects(items)

HeisenBugDev.UsersShowRoute = Em.Route.extend
  serialize: (model) ->
    user_id: model.get 'param'