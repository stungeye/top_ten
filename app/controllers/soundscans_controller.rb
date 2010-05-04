class SoundscansController < ApplicationController
  # GET /soundscans
  # GET /soundscans.xml
  def index
    @soundscans = Soundscan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @soundscans }
    end
  end

  # GET /soundscans/1
  # GET /soundscans/1.xml
  def show
    @soundscan = Soundscan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @soundscan }
    end
  end

  # GET /soundscans/new
  # GET /soundscans/new.xml
  def new
    @soundscan = Soundscan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @soundscan }
    end
  end

  # GET /soundscans/1/edit
  def edit
    @soundscan = Soundscan.find(params[:id])
  end

  # POST /soundscans
  # POST /soundscans.xml
  def create
    @soundscan = Soundscan.new(params[:soundscan])

    respond_to do |format|
      if @soundscan.save
        flash[:notice] = 'Soundscan was successfully created.'
        format.html { redirect_to(@soundscan) }
        format.xml  { render :xml => @soundscan, :status => :created, :location => @soundscan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @soundscan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /soundscans/1
  # PUT /soundscans/1.xml
  def update
    @soundscan = Soundscan.find(params[:id])

    respond_to do |format|
      if @soundscan.update_attributes(params[:soundscan])
        flash[:notice] = 'Soundscan was successfully updated.'
        format.html { redirect_to(@soundscan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @soundscan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /soundscans/1
  # DELETE /soundscans/1.xml
  def destroy
    @soundscan = Soundscan.find(params[:id])
    @soundscan.destroy

    respond_to do |format|
      format.html { redirect_to(soundscans_url) }
      format.xml  { head :ok }
    end
  end
end
