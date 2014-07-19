HeisenBugDev.Project = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  code_repo: DS.attr 'string'
  subtitle: DS.attr 'string'
  icon: DS.attr 'string'

  # == Leave commented out until models implemented ==
  wiki: DS.belongsTo 'wiki'
  # builds: DS.hasMany 'builds'
  # versions: DS.hasMany 'versions'
