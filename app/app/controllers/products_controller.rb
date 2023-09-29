class ProductsController < ApplicationController
  def index
     @categories = Category.left_outer_joins(:products).distinct.select('categories.*, COUNT(products.id) AS products_count').group('categories.id').order(name: :asc).load_async
     @all = Category.joins(:products).count

     @pagy, @products = pagy(FindProducts.new.call(params).load_async, items: 12)
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
