# -*- encoding : utf-8 -*-
class Import4LogsController < ApplicationController
  # GET /import4_logs
  # GET /import4_logs.xml
  def index
    @import4_logs = Import4Log.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @import4_logs }
    end
  end

  # GET /import4_logs/1
  # GET /import4_logs/1.xml
  def show
    @import4_log = Import4Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @import4_log }
    end
  end

  # GET /import4_logs/new
  # GET /import4_logs/new.xml
  def new
    @import4_log = Import4Log.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @import4_log }
    end
  end

  # GET /import4_logs/1/edit
  def edit
    @import4_log = Import4Log.find(params[:id])
  end

  # POST /import4_logs
  # POST /import4_logs.xml
  def create
    @import4_log = Import4Log.new(params[:import4_log])

    respond_to do |format|
      if @import4_log.save
        format.html { redirect_to(@import4_log, :notice => 'Import4 log was successfully created.') }
        format.xml  { render :xml => @import4_log, :status => :created, :location => @import4_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @import4_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /import4_logs/1
  # PUT /import4_logs/1.xml
  def update
    @import4_log = Import4Log.find(params[:id])

    respond_to do |format|
      if @import4_log.update_attributes(params[:import4_log])
        format.html { redirect_to(@import4_log, :notice => 'Import4 log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @import4_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /import4_logs/1
  # DELETE /import4_logs/1.xml
  def destroy
    @import4_log = Import4Log.find(params[:id])
    @import4_log.destroy

    respond_to do |format|
      format.html { redirect_to(import4_logs_url) }
      format.xml  { head :ok }
    end
  end
end
