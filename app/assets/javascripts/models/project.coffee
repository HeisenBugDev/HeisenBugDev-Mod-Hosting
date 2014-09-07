HeisenBugDev.Project = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  code_repo: DS.attr 'string'
  download_sentence: DS.attr 'string'
  main_download: DS.attr 'string'
  latestReleaseBuild: DS.belongsTo 'build'
  latestBetaBuild: DS.belongsTo 'build'
  latestNormalBuild: DS.belongsTo 'build'
  icon: DS.attr 'string'
  wiki: DS.belongsTo 'wiki', async: true
  builds: DS.hasMany 'builds', async: true
  versions: DS.hasMany 'versions', async: true
  downloads: DS.attr 'number'
  slug: DS.attr 'string'
  owner_sentence: DS.attr 'string'
