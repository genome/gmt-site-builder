class BuildSite
  def self.execute!(repos = nil)
    repos ||= GithubApi.get_repos_for_organization(GMTSiteBuilder.config.github_organization_name)
      .map { |r| Repo.new(r) }
      .select { |r| r.is_gmt? }

    BuildSite.new(repos)
  end

  private
  def initialize(repos)
    jekyll_site = JekyllSite.new
    repos.each { |r| ToolExporter.new(r, jekyll_site).export! }
  end
end
