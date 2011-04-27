# -*- encoding : utf-8 -*-
class Import2LogsController < ApplicationController
  before_filter :authenticate_user!
  # GET /import2_logs
  # GET /import2_logs.xml
  def index
    @import2_logs = Import2Log.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @import2_logs }
    end
  end

  # GET /import2_logs/1
  # GET /import2_logs/1.xml
  def show
    @import2_log = Import2Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @import2_log }
    end
  end

  # GET /import2_logs/new
  # GET /import2_logs/new.xml
  def new
    @import2_log = Import2Log.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @import2_log }
    end
  end

  # GET /import2_logs/1/edit
  def edit
    @import2_log = Import2Log.find(params[:id])
  end

  # POST /import2_logs
  # POST /import2_logs.xml
  def create
    @import2_log = Import2Log.new(params[:import2_log])

    respond_to do |format|
      if @import2_log.save
        format.html { redirect_to(@import2_log, :notice => 'Import2 log was successfully created.') }
        format.xml  { render :xml => @import2_log, :status => :created, :location => @import2_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @import2_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /import2_logs/1
  # PUT /import2_logs/1.xml
  def update
    @import2_log = Import2Log.find(params[:id])

    respond_to do |format|
      if @import2_log.update_attributes(params[:import2_log])
        format.html { redirect_to(@import2_log, :notice => 'Import2 log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @import2_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /import2_logs/1
  # DELETE /import2_logs/1.xml
  def destroy
    @import2_log = Import2Log.find(params[:id])
    @import2_log.destroy

    respond_to do |format|
      format.html { redirect_to('/import2') }
      format.xml  { head :ok }
    end
  end
end
