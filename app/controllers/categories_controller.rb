class CategoriesController < ApplicationController
	  before_action :authenticate, except: [:index, :show]
  # GET /category/new
  def new
    @category = Category.new
  end

  def index 
    @categories = Category.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
  end 

	def show
		if params[:id]
		  @categories = Category.all
		  @categoryFind = Category.find params[:id]
		  @articles = @categoryFind.articles.search(params[:search]).paginate(:page => params[:page], :per_page => 4)
		end
	end

  # POST /category
  # POST /category.json
  def create
    @category = Category.new(categories_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to articles_path, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
	def categories_params
	  params.require(:category).permit(:name)
	end
end