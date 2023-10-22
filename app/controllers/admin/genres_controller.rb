class Admin::GenresController < ApplicationController
  # ryon
  def index
    # 新しいジャンルの作成用
    @genre = Genre.new
    # 一覧で既存のジャンルを表示する為にジャンル検索
    @genres = Genre.all
  end

  def create
    # 新しいジャンルオブジェクトを作成し、初期化
    @genre = Genre.new(genre_params)
    # ↑のデータベースを保存
    if @genre.save
    # 正常に保存されたら管理者ジャンル一覧にリダイレクト
      redirect_to admin_genres_path
    else
    # エラーの場合ジャンル一覧に戻る
      @genres = Genre.all
      redirect_to admin_genres_path
      
    end
  end

  def edit
    # idに一致するジャンル検索
    @genre = Genre.find(params[:id])
  end

  def update
    # idに一致するジャンル検索
    @genre = Genre.find(params[:id])
    # データベース内のジャンル情報を更新
    if @genre.update(genre_params)
    # ジャンルの変更後一覧画面にリダイレクト
      redirect_to admin_genres_path
    else
      # エラーの場合ジャンル編集に戻る
      render :edit
      # redirect_to admin_genre_path
    end
  end

  private

  def genre_params
    # requireでgenreのキーを持つデータを要求
    # permitで受け入れ可能な属性を指定(ここではnameのみ)
    params.require(:genre).permit(:name)
  end

end
