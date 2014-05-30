class ForumController < ApplicationController
    
  def index
    @page_title = 'Forum'
    @posts = ForumPost.paginate(page: params[:page], :per_page => 20, :order => 'root_id desc, lft')
  end

  def reply
    reply_to = ForumPost.find(params[:id])
    @page_title = "Reply to '#{reply_to.subject}'"
    @post = ForumPost.new(:parent_id => reply_to.id)
    render :action => 'post'
  end

  def show
    @post = ForumPost.find(params[:id])
    @page_title = "'#{@post.subject}'"
  end

  def post
    @page_title = 'Post to forum'
    @post = ForumPost.new
  end
  
  def create
    @post = ForumPost.new(params[:post])
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to :action => 'index'
    else
      @page_title = 'Post to forum'
      render :action => 'post'
    end
  end
  def destroy
    @post = ForumPost.find(params[:id])
    @post.destroy 
    flash[:notice] = "El post #{@post.subject} ha sido eliminado."
    redirect_to :action => 'index'
  end
end
