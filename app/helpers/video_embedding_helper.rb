# create custom tags for redcarpet to insert youtube|vimeo iframes in 
# your document. 
# ::usage:: vid(youtube, 123456)
module VideoEmbeddingHelper
  class VideoMarkdownRenderer < Redcarpet::Render::HTML
    include ActionView::Helpers::AssetTagHelper

    def preprocess(document)
      document.gsub!(youtube_regex) do |match|
        youtube_video_embed($1)
      end

      document.gsub!(vimeo_regex) do |match|
        vimeo_video_embed($1)
      end

      document
    end

    private

    def youtube_regex
      %r{(?:https?://)?(?:www\.)?(?:youtube\.com/watch\?v=|youtu\.be/|youtube\.com/embed/|youtube\.com/v/|youtube\.com/user/.+/u/|youtube\.com/attribution_link\?.*v%3D|youtube\.googleapis\.com/v/)([a-zA-Z0-9_-]+)(?:\?[^'"\s]+)?}
    end

    def vimeo_regex
      %r{(https?://(?:www\.)?vimeo\.com/(\d+))}
    end

    def youtube_video_embed(video_id)
      content_tag(:iframe, nil, 
                  width: '100%', 
                  height: 'auto', 
                  src: "https://www.youtube.com/embed/#{video_id}?autoplay=1", 
                  class: 'embed-responsive-item',
                  allowfullscreen: true,
                  frameborder: 1
      )
    end
    
    def vimeo_video_embed(video_id)
      content_tag(:iframe, nil, 
                  width: '100%', 
                  height: 'auto', 
                  src: "https://player.vimeo.com/video/#{video_id}", 
                  class: 'embed-responsive-item',
                  allowfullscreen: true,
                  frameborder: 1
      )
    end        
  end
end  