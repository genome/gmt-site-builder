require 'erb'
require 'yaml'
require 'base64'
require 'octokit'
require 'kramdown'
require 'fileutils'

require 'gmt-site-builder/util'
require 'gmt-site-builder/icon'
require 'gmt-site-builder/repo'
require 'gmt-site-builder/release'
require 'gmt-site-builder/version'
require 'gmt-site-builder/menu_page'
require 'gmt-site-builder/build_site'
require 'gmt-site-builder/jekyll_site'
require 'gmt-site-builder/repo_config'
require 'gmt-site-builder/tool_exporter'
require 'gmt-site-builder/validate_repos'

module GMTSiteBuilder
  class << self
    attr_accessor :config
  end

  def self.configure
    yield(config)
  end

  class Configuration
    attr_accessor :github_organization_name
    attr_accessor :jekyll_tool_image_directory
    attr_accessor :tool_config_file_name
    attr_accessor :jekyll_tool_directory
    attr_accessor :jekyll_data_directory
    attr_accessor :jekyll_repo_directory
    attr_accessor :jekyll_posts_directory
    attr_accessor :template_directory

    def initialize
      @github_organization_name    = 'genome'
      @tool_config_file_name       = 'gmt.yml'
      @jekyll_tool_directory       = 'packages'
      @jekyll_data_directory       = '_data'
      @jekyll_posts_directory      = '_posts'
      @jekyll_tool_image_directory = 'res/images'
      @template_directory          = File.expand_path('gmt-site-builder/template', File.dirname( __FILE__))
      @jekyll_repo_directory       = nil
    end
  end

  self.config ||= Configuration.new
end
