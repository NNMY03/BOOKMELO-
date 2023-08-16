class Public::BooksController < ApplicationController

  def search
    @range = params[:range] #検索モデル

    # resultsに検索結果を格納する
    @book = []

    # タイトルで検索する場合
    @keyword = params[:keyword]
    # 楽天APIを使用して検索ワードの書籍が存在するか確認する
     if @range == "title"
     results =  RakutenWebService::Books::Book.search({
        title: @keyword,
     })
     results.each do |result|
       book = Book.new(read(result))
       @book << book
      end
     end

    # 著者で検索する場合
    # 楽天APIを使用して検索ワードの書籍が存在するか確認する
     if @range == "author"
     results =  RakutenWebService::Books::Book.search({
        author: @keyword,
     })
     results.each do |result|
       book = Book.new(read(result))
       @book << book
      end
     end

   # すでにデータを取り込み済みか選別する
     @book.each do |book|
       unless Book.all.include?(book)
         book.save
       end
     end
  end
  
  def show
    @book = Book.find(params[:id])
    @posts = Post.all
  end
  
  def index
    if customer_signed_in?
    @posts = Post.posted_status
    else admin_signed_in?
    @posts = Post.all
    end    
  end



  # 各カラムへデータを保存する
  private
  def read(result)
    title = result["title"]
    author = result["author"]
    isbn = result["isbn"]
    publisher = result["publisherName"]
    img_small = result["mediumImageUrl"]
    img_big = result["largeImageUrl"]
    rakuten_url = result["itemUrl"]
    item_caption = result["itemCaption"]
    book_genre_id = result["booksGenreId"]
    {
      title: title,
      author: author,
      rakuten_url: rakuten_url,
      isbn: isbn,
      img_small: img_small,
      img_big: img_big,
      book_genre_id: book_genre_id,
      item_caption: item_caption,
      publisher: publisher,
    }
  end
end
