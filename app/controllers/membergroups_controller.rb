class MembergroupsController < ApplicationController

  def index
    @membergroups = Membergroup.all
  end

end