# == Schema Information
#
# Table name: project_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ProjectList < ActiveRecord::Base
end
