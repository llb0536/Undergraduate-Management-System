# -*- encoding : utf-8 -*-
require 'json'
require 'spreadsheet'

class TablesController < ApplicationController
  # GET /tables
  # GET /tables.xml
  def index
    @tables = Table.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tables }
    end
  end

  # GET /tables/1
  # GET /tables/1.xml
  def show
    @table = Table.find(params[:id])
    @result = JSON.parse(@table.result)
    @reason = JSON.parse(@table.reason)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @table }
      format.xls {
        Spreadsheet.client_encoding = 'UTF-8'
        
        book = Spreadsheet::Workbook.new
        sheet1 = book.create_worksheet :name => @table.name

        sheet1.row(0).replace %w{排名 姓名 加权平均 学号 班级}
        sheet1.row(0).height = 20
        
        format = Spreadsheet::Format.new :weight => :bold,
                                         :size => 10
        sheet1.row(0).default_format = format

        bold = Spreadsheet::Format.new :weight => :bold
          
        sheet1.column(0).width = 3
        sheet1.column(1).width = 10
        sheet1.column(2).width = 10
        sheet1.column(3).width = 15
        sheet1.column(4).width = 10
    	  i=1
    		@result.each do |key,value|
    		  student = Student.find(key)
    		  sheet1.row(i).replace [i,student.name,sprintf("%.2f",value),student.number,student.banji]
    		  sheet1.row(i).set_format(0, bold)
    		  i+=1
        end
        
        data = StringIO.new('')
        book.write(data)  
        send_data(data.string, :filename => "#{@table.name}.xls")
      }
    end
  end
  
  

  # GET /tables/new
  # GET /tables/new.xml
  def new
    @table = Table.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @table }
    end
  end

  # GET /tables/1/edit
  def edit
    @table = Table.find(params[:id])
  end

  # POST /tables
  # POST /tables.xml
  def create
    @table = Table.new(params[:table])
    
    respond_to do |format|
      if @table.save
        format.html { redirect_to(@table, :notice => 'Table was successfully created.') }
        format.xml  { render :xml => @table, :status => :created, :location => @table }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tables/1
  # PUT /tables/1.xml
  def update
    @table = Table.find(params[:id])

    respond_to do |format|
      if @table.update_attributes(params[:table])
        format.html { redirect_to(@table, :notice => 'Table was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.xml
  def destroy
    @table = Table.find(params[:id])
    @table.destroy

    respond_to do |format|
      format.html { redirect_to(tables_url) }
      format.xml  { head :ok }
    end
  end
end
