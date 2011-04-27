# -*- encoding : utf-8 -*-
class Import3LogsController < ApplicationController
  before_filter :authenticate_user!
  # GET /import3_logs
  # GET /import3_logs.xml
  def index
    @import3_logs = Import3Log.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @import3_logs }
    end
  end

  # GET /import3_logs/1
  # GET /import3_logs/1.xml
  def show
    @import3_log = Import3Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @import3_log }
    end
  end

  # GET /import3_logs/new
  # GET /import3_logs/new.xml
  def new
    @import3_log = Import3Log.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @import3_log }
    end
  end

  # GET /import3_logs/1/edit
  def edit
    @import3_log = Import3Log.find(params[:id])
  end

  # POST /import3_logs
  # POST /import3_logs.xml
  def create
    @import3_log = Import3Log.new(params[:import3_log])

    respond_to do |format|
      if @import3_log.save
        format.html { redirect_to(@import3_log, :notice => 'Import3 log was successfully created.') }
        format.xml  { render :xml => @import3_log, :status => :created, :location => @import3_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @import3_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /import3_logs/1
  # PUT /import3_logs/1.xml
  def update
    @import3_log = Import3Log.find(params[:id])

    respond_to do |format|
      if @import3_log.update_attributes(params[:import3_log])
        format.html { redirect_to(@import3_log, :notice => 'Import3 log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @import3_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /import3_logs/1
  # DELETE /import3_logs/1.xml
  def destroy
    @import3_log = Import3Log.find(params[:id])
    @import3_log.destroy

    respond_to do |format|
      format.html { redirect_to(import3_logs_url) }
      format.xml  { head :ok }
    end
  end
end
