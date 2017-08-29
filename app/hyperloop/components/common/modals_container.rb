class ModalsContainer < Hyperloop::Router::Component

  def render
    div do
      div do
        if ToastContainer
          ToastContainer(position: 'bottom-center', autoClose: 4000)
        end
      end
      ModalsService.opened_modals.each do |key, value|
        div do
          React.create_element(value['class'], value['params'])
        end
      end
    end
  end
end

