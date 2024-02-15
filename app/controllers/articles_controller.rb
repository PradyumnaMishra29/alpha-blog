class ArticlesController < ApplicationController
	
	def show
		#byebug
		@article = Article.find(params[:id])
	end

	def index
		@articles = Article.all
	end

	def new 
		@article = Article.new
	end

	def create
		@article = Article.new(params.require(:article).permit(:title, :description)) #it took the required param id and permited the field like title and description
		if @article.save
			flash[:notice] = "Article was created successfully."
			redirect_to @article #alternative code of this line 'redirect_to article_path(@article)'
		else
			render 'new'
		end
	end

end