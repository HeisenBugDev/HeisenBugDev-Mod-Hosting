HeisenBugDev.Wiki = DS.Model.extend
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  project: DS.belongsTo 'project'
  categories: DS.hasMany 'categories'
