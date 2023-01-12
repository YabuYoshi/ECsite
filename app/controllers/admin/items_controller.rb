class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @item }
    end
  end

  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id

    respond_to do |wants|
      if @item.save
        flash[:notice] = 'ModelClassName was successfully created.'
        wants.html { redirect_to(@item) }
        wants.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    @items = Item.page(params[:page])

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @items }
    end
  end

  def show
    @item = Item.find(params[:id])
    @items = @admin.items.page(params[:page])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @item }
    end
  end
  private

  def item_params
    params.require(:item).permit(:name,:introduction,:price,:image,:is_active,:genre)
  end

end
