require 'optparse'
require 'ostruct'

class GMTSiteOptParser
  def self.parse(args)
    options = OpenStruct.new
    opts = OptionParser.new do |o|
      o.banner = 'Usage: build-gmt-site [opts] <gmt site repo path>'

      o.on("-o", "--organization-name ORGNAME", "Organization name to use on GitHub") do |orgname|
        options.organization_name = orgname
      end

      o.on("-t", "--github-oauth-token TOKEN", "OAuth token for GitHub access. Falls back on TGI_GITHUB_OAUTH_TOKEN environment variable") do |orgname|
        options.organization_name = orgname
      end

      o.on("-v", "--validate-repo-config [REPO1,REPO2]", Array, "Validate config for GitHub repos and exit") do |repos|
        options.validate_only = true
        options.repos_to_validate = repos || []
      end

      o.on("-h", "--help", "Display this screen") do
        puts o
        exit
      end
    end
    opts.parse!(args)

    if (ARGV.empty? || ARGV.size > 1) && !options.validate_only
      puts opts
      exit(-1)
    end

    options.tap do |o|
      o.github_oauth_token ||= ENV['TGI_GITHUB_OAUTH_TOKEN']
      o.organization_name ||= 'genome'
      o.jekyll_repo_directory = ARGV.pop
    end
  end
end
