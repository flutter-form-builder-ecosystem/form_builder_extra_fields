## [10.2.0]

* Update dependencies:
  * `intl` from ^0.18.1 to ^0.19.0
  * `dart sdk` from >=3.0.0 <4.0.0 to >=3.4.0 <4.0.0
  * `flutter` from >=3.10.0 to >=3.22.0
  * `form_builder_validators` from ^9.1.0 to ^10.0.1
  * `flutter_form_builder` from ^9.1.1 to ^9.3.0
  * `flutter_lints` from ^2.0.3 to ^4.0.0
* Resolved deprecation warning. using super.key instead of super(key: key) https://dart.dev/tools/linter-rules/use_super_parameters
* Migrate to applying Gradle Plugins with the declarative plugins block: https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply 

## [10.1.0]

* `FormBuilderTypeAhead`: Add new properties
* Update dependencies
* Built with Flutter 3.13

## [10.0.0]

### BREAKING CHANGE

* Update constraints to Dart 3
* Update constraints to Flutter 3.10
* Update `flutter_form_builder` to 9.x.x. Take a look breaking changes on [there changelog](https://pub.dev/packages/flutter_form_builder/changelog#900)

## [10.0.0-dev.2]

### BREAKING CHANGE

* Update constraints to Dart 3

## [10.0.0-dev.1]

### BREAKING CHANGE

* Update constraints to Flutter 3.10
* Update intl to 0.18

## [9.0.0]

### BREAKING CHANGE

* Remove `FormBuilderChipsInput` field
* Remove `FormBuilderCupertinoDateTimePicker` field
* Update `flutter_form_builder` to 8.x.x. Take a look breaking changes on [there changelog](https://pub.dev/packages/flutter_form_builder/changelog#800)

### Features

* `FormBuilderColorPickerField`: Add `availableColors` property

## [8.5.0]

* Remove flutter_chips_input dependency
* Remove touch_input dependency
* Update dependencies
* Built with Flutter 3.7

## [8.4.0] - 28-Oct-2022

* Set by default flex loose to `FormBuilderSearchableDropdown`
* Set show search field by default
* Added customization support for color picker field
* Bumped dependencies :
  * `flutter_form_builder` from 7.3.1 to 7.7.0
  * `dropdown_search` from 5.0.2 to 5.0.3
* Performance improvement on FormBuilderSignaturePad on Web

## [8.3.0] - 27-Jul-2022

* Apply license BSD-3-clause
* Update dependency dropdown_search from 4.0.1 to 5.0.2
* Refactor readme 

## [8.2.0] - 12-Jul-2022

* Moved repository

## [8.1.0] - 18-May-2022

* Bump up `dropdown_search` package version
* Export the whole `dropdown_search` package

## [8.0.1] - 17-May-2022

* Add missing attributes for `FormBuilderSearchableDropdown`

## [8.0.0] - 16-May-2022

* Flutter 3 compatibility

## [7.1.0] - 31-Jan-2022

* Use `flutter_datetime_picker_bdaya` instead of the unmaintained `flutter_datetime_picker`
* TypeAhead onReset uses `valueTransformer`
* Export the class `TextFieldProps` - prevents importing from transitive dependency `dropdown_search`

## [7.0.0] - 27-Oct-2021

* `flutter_form_builder` ^7.0.0 compatibility
* Upgraded packages

## [7.0.0-alpha.6] - 10-Sep-2021

* Upgraded `flutter_colorpicker` dependency - comes with improvements to `FormBuilderColorPicker` field
* Upgraded `dropdown_search` dependency - comes with improvements to `FormBuilderDropdownSearch` field
* **Breaking Changes**: comes with breaking  changes in `FormBuilderColorPicker` modes

## [7.0.0-alpha.5] - 02-Sep-2021

* Upgrade form_builder to v7.0.0-alpha.3

## [7.0.0-alpha.4] - 25-May-2021

* Use null-safe version of `flutter_chips_input`
* Rename `InputType` to `CupertinoDateTimePickerInputType` - avoids name clash with `form_builder_fields`

## [7.0.0-alpha.3] - 17-May-2021

* Replaced `rating_bar` packge with a popular, better maintained and null-safe `flutter_rating_bar`

## [7.0.0-alpha.2] - 17-May-2021

* Improvements to package documentation and example

## [7.0.0-alpha.1] - 16-May-2021

* Split into own package from `flutter_form_builder`
