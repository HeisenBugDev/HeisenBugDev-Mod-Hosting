HeisenBugDev.Category = DS.Model.extend
  title: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  wiki: DS.belongsTo 'wiki'
  articles: DS.hasMany 'articles'
  subcategories: DS.hasMany 'categories'
  parent_category: DS.belongsTo 'category'