class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:edit, :show, :update, :destroy]
  
  def index
    @cocktails = Cocktail.all
  end

  def new
    @cocktail = Cocktail.new
  end

  def edit
  end

  def show
    @dose = Dose.new
    @ingredients = Ingredient.all
  end

  def create
    @cocktail = Cocktail.new(cocktails_params)
    if  @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end
  
  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
      
  def cocktails_params
    params.require(:cocktail).permit(:name)
  end
end
