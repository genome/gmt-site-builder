module GithubApi
  def self.get_repos_for_organization(organization_name)
    Octokit.organization(organization_name)
      .rels[:repos]
      .get
      .data
  end

  def self.get_file_for_repo_and_path(repo, path)
    resp = repo
      .rels[:contents]
      .get(uri: { path: path })
    Base64.decode64(resp.data[:content])
  end

  def self.get_releases_for_repo(repo)
    repo.rels[:releases]
      .get
      .data
  end
end
