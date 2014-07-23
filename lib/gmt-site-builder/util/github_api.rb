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
    releases = repo.rels[:releases]
      .get
      .data
    add_commit_dates_to_releases(repo, releases).sort_by(&:commit_date).reverse
  end

  private
  def self.add_commit_dates_to_releases(repo, releases)
    tags = repo.rels[:tags].get.data
    #github api doesn't provide a direct way to get from release -> tag -> commit
    #hence this garbage
    releases.each do |release|
      matching_tags = tags.select { |t| t.name == release.tag_name }
      raise "Ambiguous tag name #{release.tag_name} in repo #{repo.name}!" if matching_tags.size > 1
      release.commit_date = matching_tags.first
        .commit
        .rels[:self]
        .get
        .data
        .commit
        .committer
        .date
    end
    releases
  end
end
