class FileUploadsController < ApplicationController
  before_action :load_repository

  def new
  end

  def create
    @repository.files.attach(params[:files])
    redirect_to repository_path(@repository)
  end

  private

  def load_repository
    @repository = Repository.find(params[:repository_id])
  end
end
