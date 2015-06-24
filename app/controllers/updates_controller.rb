require 'rest_client'
class UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  TELEGRAM_BOT_URL = "https://api.telegram.org/bot117177519:AAGI170CuXJV8quNcVfHhBoK2b1NLIOulFc/"
  # GET /updates
  # GET /updates.json
  def index
    @updates = Update.all
  end

  # GET /updates/1
  # GET /updates/1.json
  def show
  end

  # GET /updates/new
  def new
    @update = Update.new
  end

  # GET /updates/1/edit
  def edit
  end

  # POST /updates
  # POST /updates.json
  def create
    @update = Update.new(update_params)

    respond_to do |format|
      if @update.save
        mess = eval(@update.message)
        return_message = { "chat_id":mess["chat"]["id"], "text":"apa itu #{mess["text"]}? apakah bisa dimakan?"}
        RestClient.post "#{TELEGRAM_BOT_URL}sendMessage", return_message
        format.html { redirect_to @update, notice: 'Update was successfully created.' }
        format.json { render :show, status: :created, location: @update }
      else
        format.html { render :new }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updates/1
  # PATCH/PUT /updates/1.json
  def update
    respond_to do |format|
      if @update.update(update_params)
        format.html { redirect_to @update, notice: 'Update was successfully updated.' }
        format.json { render :show, status: :ok, location: @update }
      else
        format.html { render :edit }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.json
  def destroy
    @update.destroy
    respond_to do |format|
      format.html { redirect_to updates_url, notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      pa = {'update_id':params[:update_id]}
      pa["message"]=params[:message].to_s
      pa
    end
end
