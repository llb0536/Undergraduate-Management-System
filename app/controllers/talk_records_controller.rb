class TalkRecordsController < ApplicationController
  # GET /talk_records
  # GET /talk_records.xml
  def index
    @talk_records = TalkRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @talk_records }
    end
  end

  # GET /talk_records/1
  # GET /talk_records/1.xml
  def show
    @talk_record = TalkRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @talk_record }
    end
  end

  # GET /talk_records/new
  # GET /talk_records/new.xml
  def new
    @talk_record = TalkRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @talk_record }
    end
  end

  # GET /talk_records/1/edit
  def edit
    @talk_record = TalkRecord.find(params[:id])
  end

  # POST /talk_records
  # POST /talk_records.xml
  def create
    @talk_record = TalkRecord.new(params[:talk_record])

    respond_to do |format|
      if @talk_record.save
        format.html { redirect_to(@talk_record, :notice => 'Talk record was successfully created.') }
        format.xml  { render :xml => @talk_record, :status => :created, :location => @talk_record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @talk_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /talk_records/1
  # PUT /talk_records/1.xml
  def update
    @talk_record = TalkRecord.find(params[:id])

    respond_to do |format|
      if @talk_record.update_attributes(params[:talk_record])
        format.html { redirect_to(@talk_record, :notice => 'Talk record was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @talk_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /talk_records/1
  # DELETE /talk_records/1.xml
  def destroy
    @talk_record = TalkRecord.find(params[:id])
    @talk_record.destroy

    respond_to do |format|
      format.html { redirect_to(talk_records_url) }
      format.xml  { head :ok }
    end
  end
end
