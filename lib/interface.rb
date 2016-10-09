class Interface

  attr_reader :menu_array, :order

  def initialize(filepath)
    @menu = Menu.new(filepath)
    @order = Order.new
    @menu_array = []
    @order_array = []
    build_menu_display
    user_interaction
  end

  def build_menu_display
    @menu.load_dishes
    @menu.dishes.each_with_index do |dish, index|
      @menu_array << "#{index + 1}. #{dish.name}  £#{'%.2f' % [dish.price]}"
    end
  end

  def user_interaction
    welcome
    build_order
    show_order
  end

  def welcome
    file_reader('/Users/malinnaleach/Programs/takeaway-challenge/lib/welcome.txt')
    display(@menu_array)
  end

  def file_reader(filepath)
    File.open(filepath) {|f| puts f.read}
  end

  def display(array)
    array.each {|string| puts string}
  end

  def build_order
    loop do
      input_request
      input = gets.chomp
      break if input.empty?
      dish = @menu.dishes[input.to_i - 1]
      quantity_request(dish.name)
      quantity = gets.chomp.to_i
      @order.add(OrderLine.new(dish, quantity))
    end
  end

  def input_request
    file_reader('/Users/malinnaleach/Programs/takeaway-challenge/lib/input_request.txt')
    print ">> "
  end

  def quantity_request(dish)
    puts "Please enter the quantity of #{dish} you would like"
    print ">> "
  end

  def show_order
    puts "\nOrder summary:"
    display(@order.order_display)
    puts "\nTotal number of dishes:  #{@order.dish_qty}"
    puts "Total cost of your order:  £#{'%.2f' % [@order.total_cost]}"
  end

end