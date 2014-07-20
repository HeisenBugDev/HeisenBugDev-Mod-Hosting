HeisenBugDev.Wiki = DS.Model.extend
  repo: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  project: DS.belongsTo 'project'
  articles: DS.hasMany 'articles'
  categories: DS.hasMany 'categories'
