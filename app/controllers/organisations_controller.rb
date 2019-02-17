class OrganisationsController < ApplicationController

  def show
  	@organisation = Organisation.create
  end

  def new
  	@organisation = Organisation.new
  end

  def create

  	@organisation = Organisation.new(organisation_params)

  	if @organisation.save
  		flash[:success] = "Organisation created!"
  		redirect_to request.referrer
  	else
  		flash[:success] = "Organisation Failed!"
  		redirect_to root_url
  	end
  end

  def destroy
  end

  private

  def organisation_params
  	params.require(:organisation).permit(:name, :rate)
  end


end
