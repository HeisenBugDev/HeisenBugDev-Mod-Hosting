attr = DS.attr
HeisenBugDev.User = DS.Model.extend
  email: attr 'string'
  name: attr 'string'

  serialize: ->
    @getProperties [ 'guid', 'id', 'email', 'name' ]