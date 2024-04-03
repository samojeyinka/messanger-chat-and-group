class  PagesController < ApplicationController
    def home 
        @messages = Message.all
    end
end