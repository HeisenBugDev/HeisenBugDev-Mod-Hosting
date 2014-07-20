HeisenBugDev.Artifact = DS.Model.extend
  name: DS.attr 'string'
  artifact: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  downloads: DS.attr 'number'
  file_size: DS.attr 'string'
  build: DS.belongsTo 'build'
