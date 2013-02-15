class WatchersController < ApplicationController
  # POST /watchers
  # POST /watchers.json
  def create
    @watcher = Watcher.new(params[:watcher])

    respond_to do |format|
      if @watcher.save
        format.html { redirect_to dashboard_path, notice: "Watching #{@watcher.username}/#{@watcher.repository}/#{@watcher.branch}" }
        format.json { render json: @watcher, status: :created, location: @watcher }
      else
        format.html { render action: "new" }
        format.json { render json: @watcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watchers/1
  # DELETE /watchers/1.json
  def destroy
    @watcher = Watcher.find(params[:id])
    @watcher.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { head :no_content }
    end
  end
end
