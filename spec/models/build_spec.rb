# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  version           :string(255)
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Build do
  pending "add some examples to (or delete) #{__FILE__}"
end
