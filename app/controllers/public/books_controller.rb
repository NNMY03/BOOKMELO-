class Public::BooksController < ApplicationController

  def search
    #検索モデル
    @range = params[:range]
    @keyword = params[:keyword]

    # resultsに検索結果を格納する
    @book = []
    #@isbns = []

    # タイトルで検索する場合
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
        @book_in_db = Book.find_by(isbn: book.isbn)
        if @book_in_db.nil?
          book.save
        else
          book.id = @book_in_db.id
        end
     end

  end

  def show
    @book = Book.find(params[:id])
    @posts = Post.all
  end

    def update
       @book = Book.find(params[:id])
     if @book.update(book_params)
       flash[:notice] = "投稿書籍を非公開にしました"
       redirect_to book_path(@book)
     else
      render :show
     end
    end

  def index
    if customer_signed_in?
    @tags = Tag.all
    @posts = Post.posted_status.order(created_at: :desc).page(params[:page])
     if params[:tag_id]
  	   @tag = Tag.find(params[:tag_id])
  	   @posts = @tag.posts.posted_status.page(params[:page])
     end

    else admin_signed_in?
    @tags = Tag.all
    @posts = Post.all.page(params[:page])
     if params[:tag_id]
  	   @tag = Tag.find(params[:tag_id])
  	   @posts = @tag.posts.posted_status.order(created_at: :desc).page(params[:page])
     end

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
