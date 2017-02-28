class LinksController < ApplicationController
  def show
    @link = Link.find_by(short_url: params[:short_url])
    if @link
      redirect_to @link.original_url.to_s
    else
      flash[:error] = "Link not found"
      redirect_to root_path
    end
  end

  def new
    @link = Link.new
  end

  def create
    link = Link.new(original_url: link_params['original_url'])
    if link.valid?
      @link = Link.create_ensuring_uniqueness(link.original_url)
      render :show
    else
      flash[:error] = "Wrong link format. Expected to be 'http://example.com'"
      redirect_to root_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end
end
