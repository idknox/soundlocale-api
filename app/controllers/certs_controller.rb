class CertsController < ApplicationController
  def letsencrypt
    render plain: ENV['LETSENCRYPT_KEY']
  end
end