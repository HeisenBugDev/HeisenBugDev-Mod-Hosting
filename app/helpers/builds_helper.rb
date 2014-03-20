module BuildsHelper
  #
  # Gets the latest builds in descending order
  # @param  project [String] Name of project
  # @param  amount = 2 [type] Amount of builds to show
  #
  # @return [Array<Build>] Latest builds
  def get_latest_builds(project, amount = 7)
    project = Project.find_by_name(project)
    project.builds.find(:first,
                        :order => 'build_number DESC',
                        :limit => amount)
  end
end
