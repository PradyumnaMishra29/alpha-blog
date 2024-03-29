class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:show, :index]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def show
		#byebug
		
	end

	def index
		#@articles = Article.all #paginate(page: params[:page], per_page: 5)
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def new 
		@article = Article.new
	end

	def edit
		
	end

	def create
		@article = Article.new(article_params) #it took the required param id and permited the field like title and description
		@article.user = current_user
		if @article.save
			flash[:notice] = "Article was created successfully."
			redirect_to @article #alternative code of this line 'redirect_to article_path(@article)'
		else
			render 'new'
		end
	end

	def update
		#byebug
		if @article.update(article_params)
			flash[:notice] = "Article was updated successfully."
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end

	private
	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description, category_ids: [])
	end

	def require_same_user
		if current_user != @article.user && !current_user.admin?
			flash[:alert] = "You can only edit or delete your own article"
			redirect_to @article
		end
	end
end