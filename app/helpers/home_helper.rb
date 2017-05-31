module HomeHelper

  def define_property(uri)
    case uri
      when RDF::URI
        if uri.host.eql?('www.uniandes.web.semantica.example.org')
          link_to uri.fragment, show_url(uri.fragment)
        else
          link_to uri.value, uri.value
        end
      else
        uri.value
    end
  end

end
