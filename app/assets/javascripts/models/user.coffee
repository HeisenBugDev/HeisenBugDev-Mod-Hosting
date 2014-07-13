HeisenBugDev.User = DS.Model.extend
  email: DS.attr 'string'
  param: DS.attr 'string'
  name: DS.attr 'string'
  slug: DS.attr 'string'

  nameLowerCase: (->
    this.get('name').toLowerCase();
  ).property('name')
