HeisenBugDev.Project = DS.Model.extend
  build_number: DS.attr 'number'
  commit: DS.attr 'string'
  minecraft_version: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  branch: DS.attr 'string'
  build_state: DS.attr 'string'
  downloads: DS.attr 'number'
  project: DS.belongs_to 'project'

  # == Leave commented out until models implemented ==
  # version: DS.belongs_to 'version'
  # artifacts: DS.hasMany 'artifacts'
  # articles: DS.hasMany 'articles'
