class HiringsController < ApplicationController
  before_action :set_hiring, only: [:show, :edit, :update, :destroy]

  # GET /hirings
  # GET /hirings.json
  def index
    @hirings = Hiring.all.page params[:page]
  end

  # GET /hirings/1
  # GET /hirings/1.json
  def show
  end

  # GET /hirings/new
  def new
    @hiring = Hiring.new
  end

  def new_upload; end

  def upload
    @saved_file = HiringUpload.create!(upload_params)
    ImportDataJob.perform_now(@saved_file)
    redirect_to hirings_path
  end

  # GET /hirings/1/edit
  def edit
  end

  # POST /hirings
  # POST /hirings.json
  def create
    @hiring = Hiring.new(hiring_params)

    respond_to do |format|
      if @hiring.save
        format.html { redirect_to hirings_url, notice: 'Hiring was successfully created.' }
        format.json { render :show, status: :created, location: @hiring }
      else
        format.html { render :new }
        format.json { render json: @hiring.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hirings/1
  # PATCH/PUT /hirings/1.json
  def update
    respond_to do |format|
      if @hiring.update(hiring_params)
        format.html { redirect_to hirings_url, notice: 'Hiring was successfully updated.' }
        format.json { render :show, status: :ok, location: @hiring }
      else
        format.html { render :edit }
        format.json { render json: @hiring.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hirings/1
  # DELETE /hirings/1.json
  def destroy
    @hiring.destroy
    respond_to do |format|
      format.html { redirect_to hirings_url, notice: 'Hiring was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hiring
    @hiring = Hiring.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hiring_params
    params.require(:hiring).permit(:name, :year, :city_id, :skill_id)
  end

  def upload_params
    { csv_file: params.require(:csv_file) }
  end
end
