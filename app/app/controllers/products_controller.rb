class ProductsController < ApplicationController
  def index
     @products = Product.all.with_attached_photo.order(created_at: :desc)
  end

  def show
    product
  end

  def new
    @product = Product.new
    @categories = Category.all.order(name: :asc)
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
    @categories = Category.all.order(name: :asc)
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
