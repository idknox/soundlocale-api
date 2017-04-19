class BaseService
  def get
    HTTParty.get(uri)
  end

  def uri
    raise NotImplementedError
  end
end