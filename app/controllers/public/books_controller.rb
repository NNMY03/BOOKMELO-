class Public::BooksController < ApplicationController
  def search
    
    # resultsに検索結果を格納する
    # タイトルで検索する場合
    @book = []
    @title = params[:title]
     if @title.present?
     results =  RakutenWebService::Books::Book.search({
        title: @title,
     })
     results.each do |result|
       book = Book.new(read(result))
       @book << book
      end
     end
     
     @books.each do |book|
       unless Book.all.inclube?(book)
         book.save
       end
     end
  end
  
  private
  def read(result)
    title = result[:title]
    author = result[:author]
    isbn = result[:isbn]
    publisher = result[:publisherName]
    img_small = result[:smallImageUrl]
    img_big = result[:largeImageUrl]
    rakuten_url = result[:

  

  
end
