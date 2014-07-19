HeisenBugDev.Category = DS.Model.extend
  title: DS.attr 'string'
  created_at: DS.attr 'date'
  updated_at: DS.attr 'date'
  wiki: DS.belongs_to 'wiki'
  articles: DS.has_many 'articles'
  subcategories: DS.has_many 'categories'
  parent_category: DS.belongs_to 'category'