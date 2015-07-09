# Change Log

## master

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
