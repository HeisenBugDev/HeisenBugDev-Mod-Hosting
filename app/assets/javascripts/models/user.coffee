HeisenBugDev.User = DS.Model.extend
  email: DS.attr 'string'
  param: DS.attr 'string'
  name: DS.attr 'string'
  slug: DS.attr 'string'
  authentication_token: DS.attr 'string'
  sign_in_count: DS.attr 'string'
  current_sign_in_at: DS.attr 'string'
  current_sign_in_ip: DS.attr 'string'
  last_sign_in_ip: DS.attr 'string'
  last_sign_in_at: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'

  nameLowerCase: (->
    this.get('name').toLowerCase();
  ).property('name')
