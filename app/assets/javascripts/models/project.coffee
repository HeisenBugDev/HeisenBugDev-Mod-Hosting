HeisenBugDev.Project = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  code_repo: DS.attr 'string'
  subtitle: DS.attr 'string'
  icon: DS.attr 'string'
  wiki: DS.belongsTo 'wiki'
  builds: DS.hasMany 'builds'

  # == Leave commented out until models implemented ==
  # versions: DS.hasMany 'versions'
