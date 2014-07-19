HeisenBugDev.Version = DS.Model.extend
  version: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  project: DS.belongs_to 'project'
  builds: DS.hasMany 'builds'
  articles: DS.hasMany 'articles'
