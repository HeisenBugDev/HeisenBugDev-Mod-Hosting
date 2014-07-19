HeisenBugDev.Project = DS.Model.extend
  repo: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  project: DS.belongsTo 'project'

  # == Leave commented out until models implemented ==
  # articles: DS.hasMany 'articles'
  # categories: DS.hasMany 'categories'
