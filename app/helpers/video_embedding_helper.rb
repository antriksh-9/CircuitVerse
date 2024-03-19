# create custom tags for redcarpet to insert youtube|vimeo iframes in 
# your document. 
# ::usage:: vid(youtube, 123456)
module VideoEmbeddingHelper

class VideoMarkdownRenderer < Redcarpet::Render::HTML
    include ActionView::Helpers::AssetTagHelper
  
    def preprocess(document)
        # scans for: vid(provider, id)
        # e.g. vid(youtube,12345)
        vidregex = Regexp.compile(/\bvid\((\S+)\,\s*(\S+)\)\s*/)
        document.to_enum(:scan, vidregex).map { Regexp.last_match }.each do |match|
            document.gsub!(match.to_s, video_div(match[1], match[2]))
        end
        document
      end      
  
    def video_div(provider, vid)
      content_tag(:div, 
        iframe_for(provider, vid), class: 'embed-responsive embed-responsive-16by9' 
      )
    end
    def iframe_for(provider, vid)
      case provider 
      when 'youtube'
        return content_tag(:iframe, nil, 
                           width: '100%', 
                           height: 'auto', 
                           src: "https://www.youtube.com/embed/#{vid}", 
                           class: 'embed-responsive-item')
      when 'vimeo'
        return content_tag(:iframe, nil, 
                           width: '100%', 
                           height: 'auto', 
                           src: "https://player.vimeo.com/video/#{vid}", 
                           class: 'embed-responsive-item')

    end
    end
  end
end
