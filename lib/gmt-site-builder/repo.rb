class Repo
  include WritableWithTemplate
  attr_reader :config

  def initialize(github_repo)
    @github_repo = github_repo
    @errors = []
    @config = get_repo_config
  end

  def name
    @github_repo.name
  end

  def short_name
    @config.short_name
  end

  def is_gmt?
    @is_gmt
  end

  def path
    @github_repo.html_url
  end

  def valid?
    @errors.none? && @config.valid?
  end

  def errors
    if @config.respond_to?(:errors)
      @config.errors + @errors
    else
      @errors
    end
  end

  def has_releases?
    if is_gmt?
      releases.any?
    else
      false
    end
  end

  def releases
    @releases ||= get_releases
  end

  private
  def get_releases
    GithubApi.get_releases_for_repo(@github_repo).map { |r| Release.new(r, @config.short_name) }
  end

  def get_repo_config
    @is_gmt = true
    config_file_name = GMTSiteBuilder.config.tool_config_file_name
    raw_repo_config = GithubApi.get_file_for_repo_and_path(@github_repo, config_file_name)
    RepoConfig.new(@github_repo, raw_repo_config)
  rescue Octokit::NotFound
    @is_gmt = false
    @errors  << "A config file was not found at #{config_file_name}"
  end

  def template_name
    'tool_config'
  end

  def destination
    :data_directory
  end

  def file_name
    config.short_name + '.yml'
  end
end
