StrongForm
===

Let's assume you use [strong parameters](https://guides.rubyonrails.org/action_controller_overview.html#strong-parameters)
and have this:

```
def update
  ...
  user.update params.require(:user).permit(permitted_user_attributes)
  ...
end

def permitted_user_attributes
  %i[first_name last_name]
end
```

Then you can simply output your form with those permitted parameters:

```
form_for(@user, permitted_attributes: permitted_user_attributes) do |f|
  f.text_field :first_name
  f.text_field :last_name
  f.text_field :internal_id
end
```

And this gem will automatically disable every field which is not allowed,
so the resulting html will be:

```
<form ...>
  <!-- not disabled, since in permitted_attributes -->
  <input type="text" name="user[first_name]"/>
  <input type="text" name="user[last_name]"/>

  <!-- disabled, since not in permitted_attributes -->
  <input type="text" name="user[internal_id]" disabled/>
</form>
```

Makes it easy to reuse form partials for different permitted attributes / user
rights.

Installation
===

Add it to your Gemfile then run bundle to install it.

```
gem 'strong_form'
```

Now you can pass `permitted_attributes` to your forms:

```
form_for @user, permitted_attributes: [:first_name, :last_name, ...] {}
```

Nested Form gem support
===

StrongForm includes support for [nested_form](https://github.com/ryanb/nested_form)
and hides the `link_to_add` and `link_to_remove` if it is not possible to create
new or remove existing records.

Code Status
===
[![Build Status](https://travis-ci.org/Stellenticket/strong_form.svg?branch=master)](https://travis-ci.org/Stellenticket/strong_form)
