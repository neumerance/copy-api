class CopyController < ApplicationController
  include CopyConcern

  def index
    render json: @copies
  end

  def show
    render json: @copy
  end

  def refresh
    AirtableToJsonFile.write
    render status: 200
  end
end
