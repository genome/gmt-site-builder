class ValidateRepos
  def self.execute!(repos, organization_name = GMTSiteBuilder.config.github_organization_name)
    repos ||= []
    ValidateRepos.new(repos, organization_name)
  end

  def valid_repos
    @valid_repos ||= @repos_to_validate.select { |r| r.valid? }
  end

  def invalid_repos
    @invalid_repos ||= @repos_to_validate.reject { |r| r.valid? }
  end

  private
  def initialize(repos, organization_name)
    @repos_to_validate = GithubApi.get_repos_for_organization(organization_name)
      .select { |r| repos.include?(r.name) || repos.empty? }
      .map { |r| Repo.new(r) }
  end
end
