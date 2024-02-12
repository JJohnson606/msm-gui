class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end


  def create
      
    @actor = Actor.new

    @actor.name = params.fetch("query_name")
    @actor.dob = params.fetch("query_dob")
    @actor.bio = params.fetch("query_bio")
    @actor.image = params.fetch("query_image")
    #@actor.director_id = params.fetch("query_director_id")
  
    if @actor.save
      flash[:notice] = "Actor created successfully."
      redirect_to("/actors/")
    else
      flash[:alert] = "Actor failed to create successfully."
      redirect_to("/actors")
    end
    pp @actor
  end
  
  def update
    the_id = params.fetch("path_id")
    actor_new = Actor.where({ :id => the_id }).at(0)
    

    actor_new.name = params.fetch("query_name")
    actor_new.dob = params.fetch("query_dob")
    actor_new.bio = params.fetch("query_bio")
    actor_new.image = params.fetch("query_image")
   
    if actor_new.valid?
      actor_new.save
      redirect_to("/actors/#{the_id}", { :notice => "Actor updated successfully."} )
    else
      redirect_to("/actors/#{the_id}",  { :alert => "Actor failed to update successfully." })
    end
  end

  
  def destroy
    the_id = params.fetch("path_id")
    delete_actor = Actor.where({ :id => the_id }).at(0)
    
    if delete_actor.destroy
      redirect_to("/actors", notice: "Actor deleted successfully.")
    else
      redirect_to("/actors", alert: "Failed to delete actor.")
    end
  end

end
