class MembersOnlyArticlesController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.where(is_member_only: true).includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :unprocessable_entity
  end

  def authenticate_user!
    render json: { error: "Unauthorized" }, status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
end
