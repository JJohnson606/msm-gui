Rails.application.routes.draw do
  
#Homepage
  get("/", { :controller => "misc", :action => "homepage" })

#Directors Routes

  get("/directors/youngest", { :controller => "directors", :action => "max_dob" })
  get("/directors/eldest", { :controller => "directors", :action => "min_dob" })

  get("/directors", { :controller => "directors", :action => "index" })
  get("/directors/:path_id", { :controller => "directors", :action => "show" })

#Movies Routes

  get("/movies", { :controller => "movies", :action => "index" })
  
  get("/movies/:path_id", { :controller => "movies", :action => "show" })

  post("insert_movie", {:controller => "movies", :action => "create"})
  
  post("modify_movie/:path_id",{:controller => "movies", :action => "update"})

  get("delete_movie/:path_id", {:controller => "movies", :action => "destroy"})


#Actors Routes

  get("/actors", { :controller => "actors", :action => "index" })
  get("/actors/:path_id", { :controller => "actors", :action => "show" })
end
 