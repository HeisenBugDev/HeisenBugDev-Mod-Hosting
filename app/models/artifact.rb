# == Schema Information
#
# Table name: artifacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  artifact   :string(255)
#  build_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_artifacts_on_build_id  (build_id)
#

class Artifact < ActiveRecord::Base
  belongs_to :build
  # attr_accessor :artifact

  mount_uploader :artifact, ArtifactUploader

  validates_presence_of :name
  validates_presence_of :artifact
  validates_presence_of :build
end
