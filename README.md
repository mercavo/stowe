# Stowe -> System
## Installation

Gemfile
```ruby
gem 'stowe', git: "git@github.com:mercavo/stowe.git", branch: 'master'
```
In packege.json.
```json
"scripts": {
    "build": "esbuild app/javascript/*.* --bundle --outdir=app/assets/builds",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
}
```

terminal
```sh
yes | rails g stowe:setup && bundle &&  yes | rails g stowe:install && rails g scaffold account name && yes | rails g stowe:admin && yes | rails g stowe:pay && yes | rails g stowe:support
```



##### Funcões
css.gg
```
gg('plus') ## icon
ggstr('plus', 'texto') ## icon e texto 

```

##### nested_form
f => form
model => Item.new
field => campo attrutes do model pai
renderizar => file para renderizar o aqruivo
title => Titulo descritivo do nested Form
destroy => exibe btn de removacao
show_form => oculta campos ja preenchidos
```
nested_form(f, model, field, renderizar, title, destroy=true, show_form=true)
nested_form(f, SupportMessage.new, 'support_messages','message_form', t('.message'), false, false)
```


##### tabs
id => Identificador unico da tab
args => args*
class=> classe css da possocao
------------------------------------
args: { name: "basic", label: t('.basic'), icon: 'tikcode',  render: "accounts/form"},
```
    tabs(id, args, classe='justify-content-start')
    
    tabs('profile', [
            { name: "basic", label: t('.basic'), icon: 'tikcode',  render: "accounts/form"},
            { name: "account", label: t('.account'), icon: 'user',  render: "users/form"},
            { name: "access", label: t('.access'), icon: 'password',  redirect: edit_user_registration_path },
        ])
```

##### modal
name* => identifiador
btnstr* => Texto do botao ao clicar exibe
renderizar* => file para renderizar o aqruivo
clase=> class modal
title=> titulo do modal
backdrop => modal fixado?
btnclass => classe do total
icon: botao tera icone?
```
modal(name:'boa', btnstr:'aaaa', renderizar:'two', classe: 'modal-xl', title: 'aaaaaaaaaaaa', backdrop: true, btnclass: 'btn-primary', icon: 'plus')
```

##### timeago

```
timeago(data)
```


##### table
model => Modelo
columns => colunas que serão exibidas
pagy => instacia pagy(Plan.all)
with_link => exibe link para show
modal=> open modal ao clicar || deve ser uma instanica modal
```
table(Subscribe , ["plan", "name", "sign", "status", "expire"] , @records)
```


