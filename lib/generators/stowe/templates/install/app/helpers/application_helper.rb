module ApplicationHelper
  include Pagy::Frontend
  
  def gg str
    aux = 'class="gg-'+str+' icontable"'
    "<i #{aux}></i>".html_safe
  end
end
