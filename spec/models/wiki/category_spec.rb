# == Schema Information
#
# Table name: wiki_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  wiki_id    :integer
#

require 'spec_helper'

describe Wiki::Category do
end
