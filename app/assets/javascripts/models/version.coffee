HeisenBugDev.Version = DS.Model.extend
  version: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  project: DS.belongsTo 'project'
  builds: DS.hasMany 'builds'
  articles: DS.hasMany 'articles'
