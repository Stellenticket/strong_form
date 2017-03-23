# Change Log

## master

### Bugs fixed

* Always respect explicitly set `disabled` html attribute. (`disabled: false` was ignored)
* Do correctly enable inputs if permitted attributes includes a hash with multiple keys. (e.g. `permitted_attributes: [:some_attr, { first_key: [], second_key: [] }]`)
* Add a `#attribute_permitted?` method to a `FormBuilder`, so one can do `f.attribute_permitted?(attr)`

## 0.0.9

* Make it work with Rails 5

* Raise ruby dependency to `>= 2.2.2`

* Test agains Rails 5, too

## 0.0.8

### Bugs fixed

* Fix typo `respond_to` --> `respond_to?`

## 0.0.7

### Bugs fixed

* Fix disabling of child attributes if only `fields_for` has permitted_attributes

* Simplify code

## 0.0.6

### Bugs fixed

* Permit array attributes with `[roles: []]`, too, not only with `[:roles]`.
  In fact it is OK to have either the symbol or a hash with the key (value is
  ignored). Makes this more compatible with Rail`s strong params.

## 0.0.5

### Bugs fixed

* Make `fields_for` work with `permitted_attributes` even if parent form was not
  initialized with them.

## 0.0.4

### Bugs fixed

* Different (saner?) way of initialization to fix stack level too deep errors
  when classes are not cached (`Module.prepend` didn't work like it should)

## 0.0.3

### Bugs fixed

* Rename `permitted_attributes` to  `_strong_form_permitted_attributes` because
  it would get overwritten if there is a helper method `permitted_attributes` in
  controller

### Build system

* Add CHANGELOG.md to gemspec

## 0.0.2

### Bugs fixed

* Allow to use non-block syntax for nested form `link_to_add`
  ([5ddc396d5bc03fdef8b4b69b4efcdd0333327ae2](https://github.com/Stellenticket/strong_form/commit/5ddc396d5bc03fdef8b4b69b4efcdd0333327ae2))

## 0.0.1

Initial release
