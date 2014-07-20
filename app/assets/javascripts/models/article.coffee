HeisenBugDev.Article = DS.Model.extend
  title: DS.attr 'string'
  body: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'

  wiki: DS.belongsTo 'wiki'
  build: DS.belongsTo 'build'
  version: DS.belongsTo 'version'
  category: DS.belongsTo 'category'
