class WatchersController < ApplicationController
  # PUT /budgets/1
  # PUT /budgets/1.json
  def update
    @watcher = Watcher.find(params[:id])
    if @watcher.update_attributes(params[:watcher])
      @watcher.check()

      redirect_to dashboard_path, notice: 'Watcher was successfully updated.'
    else
      redirect_to dashboard_path, notice: 'Watcher was NOT successfully updated.'
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @watcher = Watcher.find(params[:id])
    if @watcher.update_attributes( :username => nil, :repository => nil, :branch => nil, :status => nil)
      redirect_to dashboard_path, notice: 'Watcher was successfully deleted.'
    else
      redirect_to dashboard_path, notice: 'Watcher was NOT successfully deleted.'
    end
  end
end
