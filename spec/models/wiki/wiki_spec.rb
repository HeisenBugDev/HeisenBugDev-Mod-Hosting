# == Schema Information
#
# Table name: wiki_wikis
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_wiki_wikis_on_project_id  (project_id)
#

require 'spec_helper'

describe Wiki::Wiki do
  pending "add some examples to (or delete) #{__FILE__}"
end
