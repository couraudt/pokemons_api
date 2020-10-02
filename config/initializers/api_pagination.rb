# frozen_string_literal: true

ApiPagination.configure do |config|
  config.page_param do |params|
    Api::BaseController.current_page_from_params(params)
  end

  config.per_page_param do |_params|
    Api::BaseController.results_per_page
  end
end
