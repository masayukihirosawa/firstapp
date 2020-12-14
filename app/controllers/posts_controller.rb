class PostsController < ApplicationController
  
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :share_post, {only: [:show]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
    @likes = Like.all
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      title: params[:title],
      content: params[:content],
      user_id: @current_user.id
      )
    if @post.save
      flash[:notice] = "メモりました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "メモを編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "メモを削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
  def share_post
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      @like = Like.find_by(post_id: params[:id])
      if @like == nil
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
      end
    end
  end
  
end