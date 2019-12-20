class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index
    if user_signed_in?
      @posts = Post.all.page(params[:page])
    else
      @posts = Post.where(published:true).page(params[:page])
    end

    if params[:category]
      @posts = @posts.where(category: params[:category])
    end

    @posts = @posts.order("created_at desc")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if params[:id] # the traditional way
      @post = Post.find(params[:id])
    else
      @post = Post.find_by_permalink(params[:year], params[:month], params[:day], params[:slug])
    end

    if !@post || !@post.published
      redirect_to root_path
    end

    @comment = Comment.new(post: @post)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

    # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :category, :published, :text)
    end
end