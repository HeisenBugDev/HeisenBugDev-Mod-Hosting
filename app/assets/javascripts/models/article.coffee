HeisenBugDev.Article = DS.Model.extend
  title: DS.attr 'string'
  body: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'

  wiki: DS.belongs_to 'wiki'
  build: DS.belongs_to 'build'
  version: DS.belongs_to 'version'
  category: DS.belongs_to 'category'
