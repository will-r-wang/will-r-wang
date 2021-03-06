require 'octokit'

class OctokitClient
  PREVIEW_HEADERS = [
    ::Octokit::Preview::PREVIEW_TYPES[:reactions],
    ::Octokit::Preview::PREVIEW_TYPES[:integrations]
  ].freeze

  def initialize(github_token:, repository:, issue_number:)
    @octokit = Octokit::Client.new(access_token: github_token)
    @octokit.auto_paginate = true
    @octokit.default_media_type = ::Octokit::Preview::PREVIEW_TYPES[:integrations]
    @repository = repository
    @issue_number = issue_number
  end

  def add_label(label:)
    @octokit.add_labels_to_an_issue(@repository, @issue_number, [label])
  end

  def add_comment(comment:)
    @octokit.add_comment(@repository, @issue_number, comment)
  end

  def add_reaction(reaction:)
    @octokit.create_issue_reaction(@repository, @issue_number, reaction, {accept: PREVIEW_HEADERS})
  end

  def close_issue
    @octokit.close_issue(@repository, @issue_number)
  end

  def fetch_from_repo(filepath)
    @octokit.contents(@repository, path: filepath)
  end

  def error_notification(reaction:, comment:, error: nil)
    add_reaction(reaction: reaction)
    add_comment(comment: comment)
    puts comment
    unless error.nil?
      puts '-----------'
      puts "Exception: #{error.full_message}"
      puts '-----------'
    end
    exit(0)
  end
end
