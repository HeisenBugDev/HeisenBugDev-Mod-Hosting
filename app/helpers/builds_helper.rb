module BuildsHelper
  #
  # Gets the latest builds in descending order
  # @param  project [String] Name of project
  # @param  amount = 2 [type] Amount of builds to show
  #
  # @return [Array<Build>] Latest builds
  def latest_builds(project, amount = nil)
    project.builds.find(:all, :order => 'build_number DESC', :limit => amount)
  end
end
