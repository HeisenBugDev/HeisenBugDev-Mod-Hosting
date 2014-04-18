module ApplicationHelper
  def gravatar_for(user, options = { size: 200 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar #{options[:class]}")
  end

  # Gets the latest builds in descending order
  # @param  project [String] Name of project
  # @param  amount = 2 [type] Amount of builds to show
  #
  # @return [Array<Build>] Latest builds
  def latest_builds(project, amount = nil)
    project.builds.order('build_number DESC').limit(amount).to_a
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active item' : 'item'

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
end
