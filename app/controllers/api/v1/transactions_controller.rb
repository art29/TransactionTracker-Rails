class Api::V1::TransactionsController < ApplicationController
  require 'csv'
  before_action :set_transaction, only: %i[ show update destroy ]
  before_action :authenticate_api_v1_user!

  # GET /api/v1/transactions
  def index
    year = params[:year].present? ? params[:year].to_i : Date.today.year
    @transactions = Transaction.all.where(user: current_api_v1_user).where(date: Date.new(year).beginning_of_year..Date.new(year).end_of_year).order(date: :asc)

    render json: @transactions
  end

  def month
    if params[:year].present?

      if params[:month].present?
        date = Date.new(params[:year].to_i, params[:month].to_i)
        @transactions = Transaction.all.where(user: current_api_v1_user).where(date: date.beginning_of_month..date.end_of_month)
      else
        date = Date.new(params[:year].to_i)
        @transactions = Transaction.all.where(user: current_api_v1_user).where(date: date.beginning_of_year..date.end_of_year)
      end

      all_categories = Category.where(user: current_api_v1_user)
      total_income = @transactions.where(category: all_categories.where(income: "income")).where(ignore_from_calculations: false).sum(:final_price)
      total_expenses = @transactions.where(category: all_categories.where(income: "expense")).where(ignore_from_calculations: false).sum(:final_price)

      sum_per_category = []
      all_categories.each do |c|
        sum_per_category << {
          category_id: c.id,
          category_name: c.name,
          sum: @transactions.where(category: c).where(ignore_from_calculations: false).sum(:final_price)
        }
      end

      quick_create = []
      @transactions.group(:hex_hash).order('count_id DESC').limit(3).count(:id).each do |hash|
        quick_create << Transaction.find_by(hex_hash: hash).as_json(only: [:name, :original_price, :original_currency, :category_id])
      end

      render json: {
        quick_create: quick_create,
        sum_per_category: sum_per_category,
        total_expenses: total_expenses,
        total_income: total_income,
        total_sum: (total_income - total_expenses),
        transactions: @transactions.order(date: :asc)
      }
    else
      render json: {error: "Missing Year Param."}, status: :unprocessable_entity
    end
  end

  def charts
    if params[:year].present?

      date = Date.new(params[:year].to_i)
      @transactions = Transaction.all.where(user: current_api_v1_user).where(ignore_from_calculations: false).where(date: date.beginning_of_year..date.end_of_year)

      if params[:category_ids].present?
        @transactions = @transactions.where(category_id: params[:category_ids])
      end

      all_categories = Category.where(user: current_api_v1_user)

      if params[:category_ids].present?
        datasets = []

        params[:category_ids].each do |cat|
          datasets << {
            label: Category.find(cat).name,
            data: []
          }
        end
      else
        datasets = [{
                      label: "Expenses",
                      data: []
                    }, {
                      label: "Income",
                      data: []
                    }]
      end

      (1..12).each do |m|
        month_date = Date.new(params[:year].to_i, m)
        month_transactions = @transactions.where(date: month_date.beginning_of_month..month_date.end_of_month)

        if params[:category_ids].present? && params[:category_ids].length > 0 && params[:category_ids][0] != "0"
          params[:category_ids].each_with_index do |cat, i|
            datasets[i][:data] << month_transactions.where(category_id: cat).sum(:final_price)
          end
        else
          datasets[0][:data] << month_transactions.where(category: all_categories.where(income: "expense")).sum(:final_price)
          datasets[1][:data] << month_transactions.where(category: all_categories.where(income: "income")).sum(:final_price)
        end
      end

      render json: datasets
    else
      render json: {error: "Missing Year Param."}, status: :unprocessable_entity
    end
  end

  def import
    if params[:csv_file].present?
      # CSV File format:  date	 price	currency	name	ignore_from_calculation	category_name	income
      CSV.parse(File.read(params[:csv_file]), col_sep: ",", row_sep: :auto, skip_blanks: true).each_with_index do |row, index|
        next if index == 0 # skip headers

        category = Category.where(user: current_api_v1_user, name: row[5], income: row[6])
        if category.count > 0
          category = category.first
        else
          category = Category.create!(user: current_api_v1_user, name: row[5], income: row[6])
        end

        Transaction.create!(user: current_api_v1_user, category: category, name: row[3], date: row[0], original_price: row[1], final_price: row[1], original_currency: row[2], final_currency: row[2], ignore_from_calculations: row[4])
      end

      render json: {success: true}, status: :ok
    else
      render json: {error: "Missing CSV File."}, status: :unprocessable_entity
    end
  end

  # GET /api/v1/transactions/1
  def show
    render json: @transaction
  end

  # POST /api/v1/transactions
  def create
    @transaction = Transaction.new(transaction_params.merge(user: current_api_v1_user))

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/transactions/1
  def destroy
    if @transaction.destroy
      render json: {success: true}, status: :ok
    else
      render json: {error: "Error while deleting the Transaction."}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.where(user: current_api_v1_user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.fetch(:transaction, {}).permit(:name, :date, :original_price, :original_currency, :final_price, :final_currency, :ignore_from_calculations, :category_id, :user_id)
    end
end
