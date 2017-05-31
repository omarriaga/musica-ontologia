class HomeController < ApplicationController
  def index
    @album = Album.new
    @list = @album.list
  end

  def instancias
    @clase = params[:clase]
    @page = params[:page].to_i
    album = Album.new
    if @page
      @list = album.get_instancias(@clase, @page)
    else
      @page = 1
      @list = album.get_instancias(@clase)
    end

  end


  def show
    @instancia = params[:instancias]
    album = Album.new
    @list = album.show(@instancia)
  end

end
