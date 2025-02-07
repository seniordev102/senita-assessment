class Api::V1::PeopleController < ApplicationController
  def index
    page = params[:page] || 1
    size = params[:size] || 10

    people_query = Person.includes(:locations, :affiliations)

    if params[:search].present?
      people_query = people_query.search(params[:search])
    end

    if params[:sort_by].present? && params[:sort_order].present?
      people_query = people_query.sorted(params[:sort_by], params[:sort_order])
    end

    @people = people_query.page(page).per(size)

    render json: {
      people: @people.map { |person| PersonDecorator.new(person).as_json },
      pagination: pagination_data(@people)
    }
  end

  private

  def pagination_data(people)
    {
      current_page: people.current_page,
      next_page: people.next_page,
      prev_page: people.prev_page,
      total_pages: people.total_pages,
      total_count: people.total_count
    }
  end

  def parsed_params
    params.permit(:page, :size, :search, :sort_by, :sort_order)
  end
end