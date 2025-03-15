## 12.0.0

### BREAKING CHANGE

* Easy way! Only need execute `dart fix --apply` on your project to fix the following changes:
  * Rename `errorBuilder` to `suggestionErrorBuilder` in `FormBuilderTypeAhead`

### Features

* Compatibility with `flutter_form_builder` 10.0.x. See details on their [changelog](https://pub.dev/packages/flutter_form_builder/changelog)
* Set minimal Flutter version to 3.29.0
* Set minimal Dart version to 3.7.0
* Allow `intl` version up to 0.21
* Update example platform setup
* Bumped dropdown_search to 6.0.2 and updated searchable dropdown by @troya2 in [#136](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/pull/136)
* build(deps): bump signature from 5.5.0 to 6.0.0 in [#134](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/pull/134)

## 11.1.0

### Features

* Set minimal Flutter version to 3.27.0
* Set minimal Dart version to 3.6.0
* Compatibility with `flutter_form_builder` 9.6.x

## 11.0.0

### BREAKING CHANGE

* `FormBuilderTypeAhead`: Update to use `flutter_typeahead` 5.x.x. Take a look how migrate on their [readme](https://pub.dev/packages/flutter_typeahead#from-4x-to-5x)

### Features

* Update android settings on example
* Set minimal Flutter version to 3.24.0
* Set minimal Dart version to 3.5.0

## 10.2.0

* Update dependencies:
  * `intl` from ^0.18.1 to ^0.19.0
  * `dart sdk` from >=3.0.0 <4.0.0 to >=3.4.0 <4.0.0
  * `flutter` from >=3.10.0 to >=3.22.0
  * `form_builder_validators` from ^9.1.0 to ^10.0.1
  * `flutter_form_builder` from ^9.1.1 to ^9.3.0
  * `flutter_lints` from ^2.0.3 to ^4.0.0
* Resolved deprecation warning. using super.key instead of super(key: key) https://dart.dev/tools/linter-rules/use_super_parameters
* Migrate to applying Gradle Plugins with the declarative plugins block: https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply 

## 10.1.0

* `FormBuilderTypeAhead`: Add new properties
* Update dependencies
* Built with Flutter 3.13

## 10.0.0

### BREAKING CHANGE

* Update constraints to Dart 3
* Update constraints to Flutter 3.10
* Update `flutter_form_builder` to 9.x.x. Take a look breaking changes on there changelog

## 10.0.0-dev.2

### BREAKING CHANGE

* Update constraints to Dart 3

## 10.0.0-dev.1

### BREAKING CHANGE

* Update constraints to Flutter 3.10
* Update intl to 0.18

## 9.0.0

### BREAKING CHANGE

* Remove `FormBuilderChipsInput` field
* Remove `FormBuilderCupertinoDateTimePicker` field
* Update `flutter_form_builder` to 8.x.x. Take a look breaking changes on there changelog

### Features

* `FormBuilderColorPickerField`: Add `availableColors` property

## 8.5.0

* Remove flutter_chips_input dependency
* Remove touch_input dependency
* Update dependencies
* Built with Flutter 3.7

## 8.4.0

* Set by default flex loose to `FormBuilderSearchableDropdown`
* Set show search field by default
* Added customization support for color picker field
* Bumped dependencies :
  * `flutter_form_builder` from 7.3.1 to 7.7.0
  * `dropdown_search` from 5.0.2 to 5.0.3
* Performance improvement on FormBuilderSignaturePad on Web

## 8.3.0

* Apply license BSD-3-clause
* Update dependency dropdown_search from 4.0.1 to 5.0.2
* Refactor readme 

## 8.2.0

* Moved repository

## 8.1.0

* Bump up `dropdown_search` package version
* Export the whole `dropdown_search` package

## 8.0.1

* Add missing attributes for `FormBuilderSearchableDropdown`

## 8.0.0

* Flutter 3 compatibility

## 7.1.0

* Use `flutter_datetime_picker_bdaya` instead of the unmaintained `flutter_datetime_picker`
* TypeAhead onReset uses `valueTransformer`
* Export the class `TextFieldProps` - prevents importing from transitive dependency `dropdown_search`

## 7.0.0

* `flutter_form_builder` ^7.0.0 compatibility
* Upgraded packages

## 7.0.0-alpha.6

* Upgraded `flutter_colorpicker` dependency - comes with improvements to `FormBuilderColorPicker` field
* Upgraded `dropdown_search` dependency - comes with improvements to `FormBuilderDropdownSearch` field
* **Breaking Changes**: comes with breaking  changes in `FormBuilderColorPicker` modes

## 7.0.0-alpha.5

* Upgrade form_builder to v7.0.0-alpha.3

## 7.0.0-alpha.4

* Use null-safe version of `flutter_chips_input`
* Rename `InputType` to `CupertinoDateTimePickerInputType` - avoids name clash with `form_builder_fields`

## 7.0.0-alpha.3

* Replaced `rating_bar` packge with a popular, better maintained and null-safe `flutter_rating_bar`

## 7.0.0-alpha.2

* Improvements to package documentation and example

## 7.0.0-alpha.1

* Split into own package from `flutter_form_builder`
