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
  
    # Initialize each renderer separately
    video_renderer = VideoEmbeddingHelper::VideoMarkdownRenderer.new(preprocess: true)
    user_tag_renderer = UserTagHelper::UserTagMarkdownRenderer.new(preprocess: true)
    circuit_renderer = CircuitEmbeddingHelper::CircuitMarkdownRenderer.new(preprocess: true)
    
    # Preprocess the document separately using each renderer
    video_html = video_renderer.preprocess(document)
    user_tag_html = user_tag_renderer.preprocess(video_html)
    circuit_html = circuit_renderer.preprocess(user_tag_html)
  
    # Allow 'iframe' tags and 'src' attributes in addition to 'strong', 'em', and 'a'
    sanitized_html = sanitize(circuit_html, tags: %w(strong em a iframe), attributes: %w(href src))
  
    sanitized_html
  end
end
