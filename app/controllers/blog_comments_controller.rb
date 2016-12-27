# encoding: utf-8

class BlogCommentsController < AnonCommentController
  before_action :set_blog_comment, only: [:show, :edit, :destroy]

  def show
    @parent=@blog_comment.blog
    return @blog_comment
  end
  
  def edit
    @blog = @blog_comment.blog
    return @blog_comment
  end
  
  def create
    @blog = Blog.find(params[:blog_id])
    if current_user
      params[:blog_comment][:user_id]=current_user.id
    end
    
    respond_to do |format|
      if Rails.env.production? 
        if current_user
          @blog_comment=@blog.blog_comment.create(blog_comment_params)
        else
          @blog_comment=verify_recaptcha(:model => @blog_comment, :message => "Oh! It's error with reCAPTCHA!") && @blog_comment.blog_comment.create(blog_comment_params)
        end
      else
        @blog_comment=@blog.blog_comment.create(blog_comment_params)
      end
      
      if @blog_comment
        format.html { redirect_to @blog, :notice=> @controller_name +t(:message_success_create)}
        format.json { render :json => @blog, :status => :created, :location => @blog }
      else
        format.html { render :action => "new" }
        format.json { render :json => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @blog_comment.destroy
    
    redirect_to blog_path(@blog_comment.blog)
  end
  
  protected
  
  def get_gg 
    return set_blog_comment
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_blog_comment
    @blog_comment = BlogComment.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_comment_params
    params.require(:blog_comment).permit(:id,:user_id,:blog_id,:name,:salt,:password,:content)
  end  
end
