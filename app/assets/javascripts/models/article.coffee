HeisenBugDev.Article = DS.Model.extend
  title: DS.attr 'string'
  body: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'

  category: DS.belongsTo 'category'
