class Release
  include WritableWithTemplate

  attr_reader :tool_name

  def initialize(github_release, tool_name)
    @tool_name = tool_name
    @github_release = github_release
  end

  def release_name
    @github_release.name
  end

  def version
    @github_release.tag_name
  end

  def body
    @body ||= Kramdown::Document.new(@github_release.body).to_html
  end

  def path
    @github_release.html_url
  end

  def date
    @github_release.published_at.strftime("%Y-%m-%d")
  end

  def file_name
    "#{date}-#{tool_name}_#{version}_released.html"
  end

  private
  def template_name
    'release_post'
  end

  def destination
    :releases_directory
  end
end
