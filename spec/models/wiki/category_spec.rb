# == Schema Information
#
# Table name: wiki_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_wiki_categories_on_parent_id  (parent_id)
#

require 'spec_helper'

describe Wiki::Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
