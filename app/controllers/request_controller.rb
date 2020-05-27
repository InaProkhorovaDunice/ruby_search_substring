class RequestController < ApplicationController
  before_action :authenticate_user!

  def index
    requests = current_user.requests
    render json: requests
  end

  def create
    search_string = request_params["search_string"]
    substring = request_params["substring"]
    result = search_substring(search_string, substring)

    @request = Request.new(
          user_id: current_user.id,
          search_string: search_string,
          substring: substring,
          result_data: result,
          result: result.length.zero? ? false : true
      )
    if @request.save
      render json: result, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def search_substring (str_a, str_b)
    result = []
    str_b.each_char do |char|
      pos = str_a.index(char)
      if pos
        !pos.zero? && result.push({substring: str_a[0..pos-1], underlined: false})
        result.push({substring: str_a[pos..pos], underlined: true})
        str_a = str_a.slice(pos + 1, str_a.length - 1)
        result.push({ substring: str_a, underlined: false}) if char == str_b.slice(-1)
      else
        result = ['No']
        break
      end
    end
    result
  end

  def destroy
    @request = current_user.requests.find_by(id: params[:id])
    if request
      @request.destroy
    else
      render json: {request: "not found"}, status: :not_found
    end
  end

  private
  def request_params
    params.require(:request).permit(:search_string, :substring)
  end

end
