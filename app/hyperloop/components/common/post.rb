class Post < Hyperloop::Component

  param title: ""

  def render
    h1 do
      params[:title]
    end
  end

end