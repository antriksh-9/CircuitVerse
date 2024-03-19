# frozen_string_literal: true

module ForumHelper
  include SimpleDiscussion::ForumPostsHelper

  def formatted_content(document)
    options = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      tables: true
    }
  
    video_renderer = VideoEmbeddingHelper::VideoMarkdownRenderer.new(preprocess: true)
    markdown = Redcarpet::Markdown.new(video_renderer, options)
    
    # Allow 'iframe' tags and 'src' attributes in addition to 'strong', 'em', and 'a'
    sanitized_html = sanitize(markdown.render(document), tags: %w(strong em a iframe), attributes: %w(href src))
    
    sanitized_html
  end  
end
