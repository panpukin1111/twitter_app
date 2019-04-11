class NeighborhoodController < ApplicationController
  
  def index 
    @neighborhoods = Neighborhood.all.paginate(page: params[:page])
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
  end
  
  def new
  end

  def create
  end

  def edit 
  end

  def update
  end

  def destroy
  end

end
