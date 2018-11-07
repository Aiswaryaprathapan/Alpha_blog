class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit,:update, :show, :destroy]
  before_action :require_user,except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
def index
@articles=Article.paginate(page: params[:page],per_page: 5)

end
  def new
    @article = Article.new
  end
  def edit

  end

def update

  if @article.update(article_params)
    flash[:notice]="article was successfully updated"
    redirect_to article_path(@article)
  else
    render 'edit'
  end
end

  def create
    @article = Article.new(article_params)
    @article.user =User.first
    if @article.save
      flash[:notice]="article was created successfully."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show

   end

   def destroy

   @article.destroy
flash[:notice] = "Article was successfully deleted"
redirect_to articles_path
end

  private
  def article_params
    params.require(:article).permit(:title,:description)
  end

  def set_article
      @article=Article.find(params[:id])
end

def require_same_user
  if current_user != @article.user and !current_user.admin?
    flash[:danger]="you can only edit or delete your own article"
    redirect_to articles_path
  end
end
end