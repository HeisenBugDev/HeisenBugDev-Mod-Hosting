module ApplicationHelper
  # Gets the latest builds in descending order
  # @param  project [String] Name of project
  # @param  amount = 2 [type] Amount of builds to show
  #
  # @return [Array<Build>] Latest builds
  def latest_builds(project, amount = 5, branch = 'master')
    query = project.builds.order('build_number DESC').limit(amount)

    if branch.nil?
      query.to_a
    else
      query.where(:branch => branch).to_a
    end
  end

  def latest_stable(project)
    query = project.builds.order('build_number DESC').limit(1).
      where.not(:build_state => 'bugged')

    if query.where(:branch => :master).blank?
      query.to_a[0]
    else
      query.where(:branch => :master).to_a[0]
    end
  end

  def branches(project)
    project.builds.pluck(:branch).uniq
  end
end
