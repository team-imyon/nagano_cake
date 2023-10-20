class Public::AddressesController < ApplicationController
  def index
    @address = Address.find(params[:id])
    @addressn = Address.new
  end

  def edit
  end

  def update
  end
end

