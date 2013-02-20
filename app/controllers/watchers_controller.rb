class WatchersController < ApplicationController
  # PUT /budgets/1
  # PUT /budgets/1.json
  def update
    @watcher = Watcher.find(params[:id])
    if @watcher.update_attributes(params[:watcher])
      redirect_to dashboard_path, notice: 'Watcher was successfully updated.'
    else
      redirect_to dashboard_path, notice: 'Watcher was NOT successfully updated.'
    end
  end
end
