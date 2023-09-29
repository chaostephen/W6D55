class CatsController < ApplicationController
    def index
        render json: Cats.all
    end

    def show
        cat = Cat.find_by(id: params[:id])

        if cat
            render json: cat
        else
            render json: { message: 'cat does not exist' }, status: :not_found
        end
    end

    def update
        cat = Cat.find_by(id: params[:id])
    
        if cat.update(cat_params)
          render json: cat
        else
          render json: cat.errors.full_messages, status: :unprocessable_entity
        end
    end

    def create
        cat = Cat.new(cat_params)

        if cat.save
          render json: cat, status: :created
        else
          render json: cat.errors.full_messages, status: :unprocessable_entity
        end  
    end

    private

    def cat_params
      params.require(:cat).permit(:id, :name, :gender, :description, :birth_date, :sex)
    end
end