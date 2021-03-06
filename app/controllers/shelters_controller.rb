class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def shelters
    redirect_to '/shelters'
  end

  def new

  end

  def create
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
    })

    shelter.save

    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = Review.all
    @users = User.all
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
    })
    shelter.save
    redirect_to '/shelters'
  end

  def destroy
    if Shelter.find(params[:id]).deletable? == false
      @shelters = Shelter.all
      flash[:notice] = "Shelter could not be deleted because all its pets have approved applications"
      render :index
    else
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end

  def pets_index
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_id = params[:shelter_id]
    @pets = Pet.all.where("shelter_id = #{@shelter_id}")
  end
end
