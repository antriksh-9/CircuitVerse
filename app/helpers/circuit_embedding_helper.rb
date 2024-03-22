module CircuitEmbeddingHelper
    class CircuitMarkdownRenderer < Redcarpet::Render::HTML
      include ActionView::Helpers::AssetTagHelper
  
      def preprocess(document)
        # Scan for CircuitVerse circuit URLs and replace them with embedded iframes
        # e.g., https://circuitverse.org/simulator/embed/binary-to-bcd-f683ef45-c8cb-4432-b4b4-d9e131cab048
        circuit_regex = %r{https?://circuitverse\.org/simulator/embed/([a-zA-Z0-9-]+)}
        document.gsub!(circuit_regex) do |match|
          circuit_id = $1
          circuit_div(circuit_id)
        end
        document
      end
  
      def circuit_div(circuit_id)
        # Generate HTML for embedding a CircuitVerse circuit based on the circuit ID
        content_tag(:iframe,
                    nil,
                    style: 'border-width:; border-style: solid; border-color:;',
                    width: '500',
                    name: 'myiframe',
                    height: '500',
                    scrolling: 'no',
                    id: 'projectPreview',
                    frameborder: '1',
                    marginheight: '0px',
                    marginwidth: '0px',
                    src: "https://circuitverse.org/simulator/embed/#{circuit_id}?theme=default&display_title=false&clock_time=true&fullscreen=true&zoom_in_out=true",
                    allowfullscreen: 'true'
        )
      end
    end
end  