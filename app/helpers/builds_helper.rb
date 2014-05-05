module BuildsHelper
  attr_reader :STATE_NAMES
  STATE_NAMES = ['beta', 'bugged', 'release', 'normal']

  def prev_commit(build)
    prev_build = build.project.builds.order('build_number DESC')
      .where('build_number < ?', build.build_number).first
    prev_build.commit unless prev_build.nil?
  end

  def changes_link(build)
    prev_commit = prev_commit(build)
    root_path = "https://github.com/#{build.project.code_repo}/"
    if prev_commit.nil?
      path_postfix = "commit/#{build.commit}"
    else
      path_postfix = "compare/#{build.commit}...#{prev_commit}"
    end
    "#{root_path}#{path_postfix}"
  end

  def dropdown_classes(build)
    if build.build_state == 'bugged'
      'disabled alert'
    end
  end

  def data_options(build)
    unless build.build_state == 'bugged'
      'is_hover:true'
    end
  end
end
