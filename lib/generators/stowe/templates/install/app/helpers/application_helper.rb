module ApplicationHelper
  include Pagy::Frontend
  
  def subscriber?
    @current_account.subscriber? || current_user.admin?
  end

  def gg str=nil
    retorno = ''
    if str.present?
      aux = 'class="gg-'+str+'"'
      retorno << "<i #{aux}></i>"
    end
    retorno.html_safe
  end


  def ggstr(icon, str)
    aux = ''
    aux << '<div class="d-flex align-items-center">'+gg(icon)+'<span class="ms-2">'+str+'</span></div>'
    aux.html_safe
  end

  # f => form, model => Item.new, field=> items, renderizar => item_form
  # destroy => false oculta o btn de deletar
  # show_form => false oculta os campos ja preenchidos
  def nested_form(f, model, field, renderizar, title, destroy=true, show_form=true)
    aux = ''
    aux << '<template data-nested-form-target="template">'
    aux << partial_nested(f, model, field, renderizar, true, destroy, show_form)
    aux << '</template>'
    aux << '<div class="p-5">'
    aux << '<h5>'+title+' <button type="button" data-action="nested-form#add" class="btn btn-primary">'+gg('add')+'</button></h5>'
    aux << partial_nested(f, model, field, renderizar, false, destroy, show_form)
    aux << '<div data-nested-form-target="target"></div>'
    aux << '</div>'
    aux.html_safe
  end

  # [
  #   {
  #     name: "aa",
  #     label: "aa",
  #     icon: 'aaaa',
  #     render: "form" ou redirect: edit_user_registration_path
  #   }
  # ]
  # id => identificador
  # args => array de objectos
  # class => classe ul
  def tabs(id, args, classe='justify-content-start')
    aux = ''
    aux << '<div class="card w-100 p-1">'
    aux << '<ul class="nav nav-tabs '+classe+'" id="'+id+'" role="tablist">'
    args.each_with_index do |arg, index|
      active = (index == 0) ? 'active': ''
      aux << tabli(arg, active)
    end
    aux << '</ul>'
    aux << '</div>'
    aux << '<div class="tab-content mt-3" id="'+id+'Content">'
    args.each_with_index do |arg, index|
      next unless arg[:render].present?
      active = (index == 0) ? 'active': ''
      aux << tabrender(arg, active)
    end
    aux << '</div>'
    aux.html_safe
  end

  # modal(name:'boa', btnstr:'aaaa', renderizar:'two', classe: 'modal-xl', title: 'aaaaaaaaaaaa', backdrop: true, btnclass: 'btn-primary', icon: 'plus')
  def modal(args)
    classe = (args[:classe].present?)? args[:classe]: ''
    btnclass = (args[:btnclass].present?)? args[:btnclass]: 'btn-primary'
    backdrop = ''
    backdrop = 'data-bs-backdrop="static"' if args[:backdrop].present?
    aux = ''
    aux << '<button type="button" class="btn '+btnclass+'" data-bs-toggle="modal" data-bs-target="#'+args[:name]+'">'+ggstr(args[:icon], args[:btnstr])+'</button>' 
    aux << '<div class="modal fade" '+backdrop+' id="'+args[:name]+'" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">'
    aux << '<div class="modal-dialog modal-dialog-centered '+classe+'">'
    aux << '<div class="modal-content">'
    if args[:title].present?
      aux << '<div class="modal-header">'
      aux << '<h5 class="modal-title">'+args[:title]+'</h5>' 
      aux <<  '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'
      aux << '</div>'
    end
    aux << '<div class="modal-body">'
    aux <<  partialrender(args[:renderizar])
    aux <<  '</div>'
    aux << '</div>'
    aux << '</div>'
    aux << '</div>'
    aux.html_safe
  end

  def timeago(date, format: :long)
    return if date.blank?
  
    content = I18n.l(date, format: format)
  
    tag.time(content,
              title: content,
              data: {
                controller: 'timeago',
                timeago_datetime_value: date.iso8601
              })
  end

  # model = Support -> model em questao para buscar a traducao, sem aspas
  # columns = ['name', 'status'] ** ver obs
  # record = @record -> do pagy
  # with_link = se ao clicar redireciona para o show

  # obs: {field: 'school_class_id', model: SchoolClass, label: 'name'} > se for hash para fazer relacionaento
  # field => table pai
  # model => Modelo que deve se relacionar
  # label => field do modelo relcionamvel
  # modal => page carregamento { todos os params do modal exeto btnstr } passando uma hash

  def table(model, columns, pagy, with_link=true, modal=nil)
        
    @pagy, records = pagy

    aux = ''
    aux << '<div class="card">'
    aux << '<div class="card-body p-5">'
    if @pagy.count == 0
      aux << '<h5 class="text-center">'+t('nothing_records')+'</h5>'
    else
      aux << '<div class="d-flex justify-content-end py-3">'
      aux << '<div class="btn-group" role="group">'
      aux << '</div>'
      aux << '</div>'

      aux << '<table class="table table-striped table-hover">'
      aux << '<thead><tr>'
      columns.each do |column|
        if column.class == Hash
          field = column[:field]
        else
          field = column
        end
        aux << '<th>'+ model.human_attribute_name(field) +'</th>'
      end
      aux << '</tr></thead>'
      aux << '<tbody>'
      records.each do |record|
        aux << '<tr>'
          aux << table_row(record, columns, with_link, modal)
        aux << '</tr>'
      end
      aux << '</tbody>'
      aux << '</table>'
      aux << '<div class="d-flex justify-content-center">'
      aux << partialrender('/util/paginate')
      aux << '</div>'

      
      
      
    end
    aux << '</div>'
    aux << '</div>'
    aux << ''
    aux.html_safe
  end


  private

  def tr_modal(modal, text)
    modal(modal)
  end

  def table_row(obj, columns, with_link, modal)
    
    aux = ''
    aux << '<tr id="'+ dom_id(obj) +'">'
    columns.each do |column|
      if  column.include?(".")
        field = eval("obj.#{column}")
      else
        if column.include?("_at")
          field = l obj[column], format: :simple
        else
          field = obj[column]
        end
      end

      if modal.present?
        modal[:btnstr] = field.to_s
        aux <<   '<td>' + modal(modal) + '</td>'
      else
        if with_link
          aux << ' <td>' + link_to( field,  obj, class: "btn") + '</td>'
        else
          aux << ' <td>' + field.to_s + '</td>'
        end
      end
      
    end
    # aux << ' <td>' + partial_action(obj) + '</td>'
    aux << '</tr>'
    aux.html_safe
  end

  def tabli(arg, classe)
    aux = ''
    aux << '<li class="nav-item" role="presentation">'
    if arg[:render].present?
      aux << '<button class="nav-link '+classe+'" id="'+arg[:name]+'-tab" data-bs-toggle="tab" data-bs-target="#'+arg[:name]+'" type="button" role="tab" aria-controls="'+arg[:name]+'" aria-selected="true">'+ggstr(arg[:icon], arg[:label])+'</button>'
    else 
      aux << link_to(ggstr(arg[:icon], arg[:label]), arg[:redirect], class: 'nav-link')
    end
    aux << '</li>'
    aux.html_safe
  end

  def tabrender(arg, classe)
    aux = ''
    aux << '<div class="tab-pane fade show '+classe+'" id="'+arg[:name]+'" role="tabpanel" aria-labelledby="'+arg[:name]+'-tab">'
    aux <<  partialrender(arg[:render])
    aux << '</div>'
    aux.html_safe
  end

  def partialrender(str)
    render partial: str
  end

  def partial_action(obj)
    render partial: 'actions', locals: {id: obj.id} 
  end

  def partial_nested(f, model, field, renderizar, pre, destroy, show_form)
    render partial: '/util/nested_form', locals: { f: f, model: model, field: field, renderizar:renderizar, pre: pre, destroy: destroy, show_form: show_form}
  end

end
