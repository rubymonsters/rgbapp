module Admin::ApplicationsHelper

  def order(field)
    if params[:order] == field
      "#{field} desc"
    else
      field
    end
  end

end
