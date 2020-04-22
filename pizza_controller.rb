require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require( 'pry' )
require_relative('./models/pizza_order')
also_reload('./models/*')

#READ:
#INDEX - list all pizza orders

get '/pizza-orders' do
    @orders = PizzaOrder.all()
    erb(:index) 
end

# CREATE:
# NEW - display form to order information

get '/pizza-orders/new' do
    erb(:new)
end


# SHOW - display single order

get '/pizza-orders/:id' do
    id = params[:id].to_i
    @order = PizzaOrder.find(id)
    erb(:show)
end


# CREATE - submit new order details

# post '/pizza-orders' do
#     order = PizzaOrder.new(params)
#     order.save()
#     erb(:create)
# end
post '/pizza-orders' do
    @order = PizzaOrder.new(params)
    @order.save()
    erb(:create)
end

# UPDATE:
# EDIT - display form to edit details
get '/pizza-orders/:id/edit' do # edit
    @order = PizzaOrder.find( params[:id] )
    erb( :edit )
  end



# UPDATE - submit amended details
post '/pizza-orders/:id' do # update
    PizzaOrder.new( params ).update
    redirect to '/pizza-orders'
  end

# DELETE/DESTROY:
# DELETE - remove order from database
post '/pizza-orders/:id/delete' do # delete
    order = PizzaOrder.find( params[:id] )
    order.delete()
    redirect to '/pizza-orders'
  end 