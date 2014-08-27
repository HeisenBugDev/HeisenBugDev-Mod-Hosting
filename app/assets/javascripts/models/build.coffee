HeisenBugDev.Build = DS.Model.extend
  build_number: DS.attr 'number'
  commit: DS.attr 'string'
  minecraft_version: DS.attr 'string'
  created_at: DS.attr 'string'
  main_download: DS.attr 'string'
  updated_at: DS.attr 'string'
  branch: DS.attr 'string'
  build_state: DS.attr 'string'
  downloads: DS.attr 'number'
  project: DS.belongsTo 'project', async: true, inverse: 'builds'
  version: DS.belongsTo 'version', async: true
  articles: DS.hasMany 'articles'
  artifacts: DS.hasMany 'artifacts'
  brief_changelog: DS.attr 'string'

  # Temp field for the create action in build_controller.rb
  modVersion: DS.attr 'string'
