module ApplicationHelper
  def gravatar_for(user, options = { size: 200 })
    size = options[:size]
    gravatar_image_tag(user.email, alt: user.name, class: "gravatar #{options[:class]}", :gravatar => { :size => size })
  end

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
    project.builds.order('build_number DESC').limit(1).where.not(:build_state => 'bugged').to_a[0]
  end

  def branches(project)
    project.builds.pluck(:branch).uniq
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active item' : 'item'

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def single_quoter(string)
    string.gsub('"', "'")
  end

  def remove_newlines(string)
    string.delete!("\n")
  end
end
