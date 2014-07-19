HeisenBugDev.Wiki = DS.Model.extend
  repo: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  project: DS.belongsTo 'project'
  articles: DS.hasMany 'articles'
  categories: DS.hasMany 'categories'
