class Pagination < Hyperloop::Router::Component
  state current_page: 1

  param page_window: 5
  param page: 1
  param per_page: 25
  param total: 0
  param onChange: nil

  before_update do
    mutate.current_page params.page if params.page != state.current_page
  end

  after_mount do
    mutate.current_page params.page if params.page != state.current_page
  end

  def go_to_page(page_no)
    mutate.current_page page_no
    params.onChange.call(state.current_page) if params.onChange.present?
  end

  def is_there_page page_no
    val = page_no > 0 && (page_no - 1) * params.per_page < params.total
    val
  end

  def shown_pages
    arr = [state.current_page]

    arr.push state.current_page - 2 if is_there_page(state.current_page - 2)
    arr.push state.current_page - 1 if is_there_page(state.current_page - 1)


    arr.push state.current_page + 1 if is_there_page(state.current_page + 1)
    arr.push state.current_page + 2 if is_there_page(state.current_page + 2)


    if arr.length < params.page_window
      if is_there_page(state.current_page - 3)
        (1..(params.page_window - arr.length)).to_a.each do |i|
          arr.push state.current_page - (2 + i) if is_there_page(state.current_page - (2 + i))
        end
      elsif is_there_page(state.current_page + 3)
        (1..(params.page_window - arr.length)).to_a.each do |i|
          arr.push state.current_page + (2 + i) if is_there_page(state.current_page + (2 + i))
        end
      end
    end

    arr.sort
  end

  def render
    span do
      if params.total > 0 && is_there_page(2)
        nav(class: 'mt-6 mb-6') do
          ul(class: 'pagination justify-content-between') do

            li(class: "page-item previous #{'disabled' if state.current_page == 1}") do
              a(class: 'page-link', href:"#") do
                i(class: 'ero-arrow-left mr-3')
                span(class: 'd-none.d-md-inline-block') {'Poprzednia strona'}
              end.on :click do |e|
                e.prevent_default
                go_to_page(state.current_page - 1)
              end
            end

            div(class: 'page-wrapper') do
              shown_pages.each do |page|
                li(class: "page-item #{'active' if state.current_page == page}") do
                  a(class: 'page-link', href: "#") do
                    page.to_s
                  end.on :click do |e|
                    e.prevent_default
                    go_to_page(page)
                  end
                end
              end

              # li.page_item do
              #   a.page_link(href: "#") {'2'}
              # end
              # li.page_item do
              #   a.page_link(href: "#") {'3'}
              # end
              # li.page_item do
              #   a.page_link(href: "#") {'4'}
              # end
              # li.page_item do
              #   a.page_link(href: "#") {'5'}
              # end
            end

            li(class: "page_item next #{'disabled' if !is_there_page(state.current_page + 1)}") do
              a(class: 'page-link', href:"") do
                span(class: 'd-none d-md-inline-block') {'Następna strona'}
                i(class: 'ero-arrow-right ml-3')
              end.on :click do |e|
                e.prevent_default
                go_to_page(state.current_page + 1)
              end
            end
          end
        end
      end
    end
  end

end