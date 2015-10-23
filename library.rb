require_relative 'author'
require_relative 'book'
require_relative 'reader'
require_relative 'order'

class Library
  attr_accessor :authors, :books, :orders, :readers

   def initialize
    @authors, @books, @orders, @readers = [], [], [], []
   end

  def add_order(order)
    @orders.push order
    @books.push order.book
    @authors.push order.book.author
    @readers.push order.reader
  end

  def most_popular_book
    return if orders.empty?
    books = self.orders.map { |order| order.book }
    count(books).max_by{ |key, value| value }.first
  end

  def often_takes_the_book(book)
    return if orders.empty?
    orders =  self.orders.select{ |order| order.book == book }
    count(orders.map(&:reader)).max_by{ |key, value| value }.first
  end

  def how_many
    return [] if orders.empty?
    count(orders.map(&:book)).sort_by(&:last).reverse![0..4]
  end


  def save_to_file
    File.open("library.txt", "w") do |f|
    	@orders.each { |i| f.puts "#{i.reader}: #{i.book} #{i.date}"}	
    end
  end


  def read_from_file
      item_fields = File.readlines("library.txt")
  end


  private

  def count(items)
    items.inject(Hash.new 0) { |hash, item| hash[item] += 1; hash }
  end

end

  author1 = Author.new 'Joan Rowling','1965'
  author2 = Author.new 'Herbert Wells','1866'
  author3 = Author.new 'Allan Poe','1809'
  author4 = Author.new 'Dan Brown','1964'

  book1 = Book.new 'Harry Potter', 'Joan Rowling'
  book2 = Book.new 'The War of the Worlds', 'Herbert Wells'
  book3 = Book.new 'Gold Bug', 'Allan Poe'
  book4 = Book.new 'The Da Vinci Code', 'Dan Brown'

  reader1 = Reader.new 'Ivan', 'ivan@li.ru', 'PV', '1','4'
  reader2 = Reader.new 'Petr', 'petr@li.ru', 'DP', '2','3'
  reader3 = Reader.new 'Kewa', 'kewa@li.ru', 'ZP', '3','2'
  reader4 = Reader.new 'Miwa', 'miwa@li.ru', 'KH', '4','1'

  library.add_order (Order.new(book2, reader1))
  library.add_order (Order.new(book2, reader2))
  library.add_order (Order.new(book2, reader3))
  library.add_order (Order.new(book2, reader4))
  library.add_order (Order.new(book3, reader2))
  library.add_order (Order.new(book3, reader3))
  library.add_order (Order.new(book1, reader1))
  library.add_order (Order.new(book4, reader4))
  library.add_order (Order.new(book1, reader1))

  library.most_popular_book
  book = library.books[0]
  library.often_takes_the_book book
  library.how_many
  library.save_to_file
  library.read_from_file