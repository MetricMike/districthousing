class ResidencesController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  before_action :set_residence, only: [:show, :edit, :update, :destroy]

  def new
    current_applicant.residences << Residence.make_a_residence

    redirect_to apply_path
  end

  # GET /residences/1/edit
  def edit
  end

  # POST /residences
  def create
    @residence = Residence.new(residence_params)

    if @residence.save
      format.json { render :show, status: :created, location: @residence }
    else
      render :new
    end
  end

  # PATCH/PUT /residences/1
  def update
    if @residence.update(residence_params)
      redirect_to apply_path, notice: 'Residence was successfully updated.'
    else
      redirect_to apply_path, notice: 'Residence could not be updated.'
    end
  end

  # DELETE /residences/1
  def destroy
    @residence.destroy
    redirect_to apply_path, notice: 'Residence was successfully destroyed.', status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_residence
      @residence = Residence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def residence_params
      params.require(:residence).permit(
        :applicant_id,
        :address_id,
        :start,
        :end,
        :reason,
        :landlord_id,
        address_attributes: [ :street, :apt, :city, :state, :zip, :id ],
        landlord_attributes: [ :first_name, :middle_name, :last_name,
          :cell_phone, :home_phone, :work_phone, :email, :id ] )
    end
end
