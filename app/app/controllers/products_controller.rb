class ProductsController < ApplicationController
  def index
     @categories = Category.left_outer_joins(:products).distinct.select('categories.*, COUNT(products.id) AS products_count').group('categories.id').order(name: :asc).load_async
     @products = Product.with_attached_photo
     @all = Category.joins(:products).count

     if params[:category_id]
        @products = @products.where(category_id: params[:category_id])
     end

     if params[:min_price].present?
        @products = @products.where("price >= ?", params[:min_price])
    end

    if params[:max_price].present?
       @products = @products.where("price <= ?", params[:max_price])
    end

    if params[:search].present?
      @products= @products.where( "MATCH( title,description ) AGAINST( ? )", params[:search] )

    end

    order_by = Product::ORDER_BY.fetch(params[:order_by]&. to_sym, Product::ORDER_BY['Recientes'])

    @products = @products.order(order_by).load_async

  end

  def show
    product
  end

  def new
    @product = Product.new
    @categories = Category.order(name: :asc).load_async
  end

  def create
    @product = Product.new(product_params)

    if @product.save
       redirect_to products_path, notice: 'El producto se ha creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
    @categories = Category.order(name: :asc).load_async
  end

  def update
    if product.update(product_params)
       redirect_to products_path, notice: 'El producto se ha actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy
    redirect_to products_path, notice: 'El producto se ha eliminado exitosamente.', status: :see_other
  end

  private
    #lista de parametros permitidos
  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end

  def product
    @product = Product.find(params[:id])
  end

end
