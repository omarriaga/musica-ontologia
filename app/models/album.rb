require 'sparql/client'
class Album

  def url
  'http://34.197.226.119:8890/sparql?default-graph-uri=http%3A%2F%2Fwww.uniandes.web.semantica.example.org%2F201528630%2Fetapa2ontology%23'
  end

  def list
    @sparql = SPARQL::Client.new(url)
    text_query = '
        PREFIX : <http://www.uniandes.web.semantica.example.org/201528630/etapa2ontology#>
        SELECT ?clase (count(distinct ?d) as ?count)
        WHERE {
          ?d rdf:type ?clase .
          ?clase rdf:type owl:Class .
          FILTER( ?clase != owl:Class)
        }
    '
    @sparql.query(text_query)
  end

  def get_instancias(clase, page=1)
    @sparql = SPARQL::Client.new(url)
    text_query = "
        PREFIX musica: <http://www.uniandes.web.semantica.example.org/201528630/etapa2ontology#>
        SELECT ?d ?name
        WHERE {
          ?d rdf:type musica:#{clase} .
          ?d #{get_nombre_rel(clase)} ?name .
        }
        offset #{50*page.to_i}
        Limit 50
    "
    @sparql.query(text_query)
  end


  def show(instancia, clase)
    @sparql = SPARQL::Client.new(url)
    text_query = "
        PREFIX : <http://www.uniandes.web.semantica.example.org/201528630/etapa2ontology#>
        SELECT ?rel ?p
        WHERE {
           :#{instancia} ?rel ?p .
            FILTER( ?p != owl:NamedIndividual )
        }
    "
    @sparql.query(text_query)
  end

  private
  def get_nombre_rel(clase)
    case clase
      when 'Album'
        'musica:Nombre_Album'
      when 'Artista'
        'musica:Nombre_artista'
      when 'Generos'
        'musica:Nombre_genero'
      when 'Canciones'
        'musica:Nombre_cancion'
      when 'Compositor'
        'musica:Nombre_compositor'
      else
        'musica:Nombre'
    end
  end

end