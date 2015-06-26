StrongForm
===

Let's assume you use [strong parameters](https://github.com/rails/strong_parameters)
and have this:

```
def user_attributes
  params.require(:user).permit(:first_name, :last_name)
end
```

Then you can simply output your form with those permitted parameters:

```
form_for(@user, permitted_attributes: user_attributes) do |f|
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

Nested Form gem support
===

StrongForm includes support for [nested_form](https://github.com/ryanb/nested_form)
and hides the `link_to_add` and `link_to_remove` if it is not possible to create
new or remove existing records.

ToDo
===

 * Allow to skip field output instead of disabling it
 * Allow to manually set replacement for a disabled field
