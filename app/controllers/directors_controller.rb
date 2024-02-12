class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
      
    @director = Director.new

    @director.name = params.fetch("query_name")
    @director.dob = params.fetch("query_dob")
    @director.bio = params.fetch("query_bio")
    @director.image = params.fetch("query_image")
    #@director.director_id = params.fetch("query_director_id")
  
    if @director.save
      flash[:notice] = "Director created successfully."
      redirect_to("/directors/")
    else
      flash[:alert] = "Director failed to create successfully."
      redirect_to("/directors")
    end
    pp @director
  end
  
  def update
    the_id = params.fetch("path_id")
    director_new = Director.where({ :id => the_id }).at(0)
    

    director_new.name = params.fetch("query_name")
    director_new.dob = params.fetch("query_dob")
    director_new.bio = params.fetch("query_bio")
    director_new.image = params.fetch("query_image")
   
    if director_new.valid?
      director_new.save
      redirect_to("/directors/#{the_id}", { :notice => "Director updated successfully."} )
    else
      redirect_to("/directors/#{the_id}", { :alert => "Director failed to update successfully." })
    end
  end

  
  def destroy
    the_id = params.fetch("path_id")
    delete_director = Director.where({ :id => the_id }).at(0)
    
    if delete_director.destroy
      redirect_to("/directors", notice: "Director deleted successfully.")
    else
      redirect_to("/directors", alert: "Failed to delete director.")
    end
  end
  

end
