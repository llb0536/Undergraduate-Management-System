# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @message = Message.new
    @messages = current_user.messages
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end
  def set_read
    @message = Message.find(params[:message_id])
    @message.has_read=true
    @message.save!
    if params[:index]=="1"
      redirect_to '/main'
    else
      redirect_to '/messages'
    end
  end
  def set_unread
    @message = Message.find(params[:message_id])
    @message.has_read=false
    @message.save!
    redirect_to '/messages'
  end
  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    @message.has_read=true
    @message.save!
    render text:'permission denied' and return if current_user.id != @message.user_id
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.from_user_id = current_user.id
    @message.has_read = false
    
    respond_to do |format|
      if @message.save
        format.html { flash[:notice]='发送成功' and redirect_to('/messages') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { @messages = current_user.messages and render :action => "index" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
