# == Schema Information
#
# Table name: artifacts
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  download_file :string(255)
#  build_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_artifacts_on_build_id  (build_id)
#

class Artifact < ActiveRecord::Base
  belongs_to :build

  validates_presence_of :name
  validates_presence_of :download_file
end
