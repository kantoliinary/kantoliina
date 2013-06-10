#encoding: utf-8

class MembergroupsController < ApplicationController

  def index
    @membergroups = Membergroup.all
  end

end