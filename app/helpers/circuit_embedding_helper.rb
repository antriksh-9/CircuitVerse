# circuit_embedding_helper.rb

module CircuitEmbeddingHelper
    
    class CircuitMarkdownRenderer < Redcarpet::Render::HTML
      include ActionView::Helpers::AssetTagHelper
    
      def preprocess(document)
        # Scan for circuit tags and replace them with embedded circuit iframes
        # e.g., circuit(sap-1-a993d26d-99c4-4fb9-a5ce-06f38f44eb98)
        circuit_regex = /\bcircuit\((\S+)\)/
        document.gsub!(circuit_regex) do |match|
          circuit_id = $1
          circuit_div(circuit_id)
        end
        document
      end
  
      def circuit_div(circuit_id)
        # Generate HTML for embedding a circuit based on the circuit ID
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
  