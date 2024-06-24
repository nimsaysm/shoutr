class HomesController < ApplicationController
    def show
        @shouts = Shout.last(5).reverse
    end
end