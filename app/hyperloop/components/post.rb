class Post < Hyperloop::Component

  param title: ""

  def render
    H1 do
      params[:title]
    end
  end

end