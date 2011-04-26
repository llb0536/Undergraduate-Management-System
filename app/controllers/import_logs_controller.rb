# -*- encoding : utf-8 -*-
class ImportLogsController < ApplicationController
  before_filter :authenticate_user!
  # GET /import_logs
  # GET /import_logs.xml
  def index
    @import_logs = ImportLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @import_logs }
    end
  end

  # GET /import_logs/1
  # GET /import_logs/1.xml
  def show
    @import_log = ImportLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @import_log }
    end
  end

  # GET /import_logs/new
  # GET /import_logs/new.xml
  def new
    @import_log = ImportLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @import_log }
    end
  end

  # GET /import_logs/1/edit
  def edit
    @import_log = ImportLog.find(params[:id])
  end

  # POST /import_logs
  # POST /import_logs.xml
  def create
    @import_log = ImportLog.new(params[:import_log])

    respond_to do |format|
      if @import_log.save
        format.html { redirect_to(@import_log, :notice => 'Import log was successfully created.') }
        format.xml  { render :xml => @import_log, :status => :created, :location => @import_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @import_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /import_logs/1
  # PUT /import_logs/1.xml
  def update
    @import_log = ImportLog.find(params[:id])

    respond_to do |format|
      if @import_log.update_attributes(params[:import_log])
        format.html { redirect_to(@import_log, :notice => 'Import log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @import_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /import_logs/1
  # DELETE /import_logs/1.xml
  def destroy
    @import_log = ImportLog.find(params[:id])
    @import_log.destroy

    respond_to do |format|
      format.html { redirect_to('/import') }
      format.xml  { head :ok }
    end
  end
end
