# Form Builder Extra Fields

FormBuilder Extra Fields provides common ready-made form input fields for [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) package. The package gives you a convenient way of adding common ready-made input fields instead of creating your own FormBuilderField from scratch.

[![Pub Version](https://img.shields.io/pub/v/form_builder_extra_fields?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_extra_fields)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/flutter-form-builder-ecosystem/form_builder_extra_fields/base.yaml?branch=main&logo=github&style=for-the-badge)](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/actions/workflows/base.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/flutter-form-builder-ecosystem/form_builder_extra_fields?logo=codecov&style=for-the-badge)](https://codecov.io/gh/flutter-form-builder-ecosystem/form_builder_extra_fields/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/flutter-form-builder-ecosystem/form_builder_extra_fields?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/flutter-form-builder-ecosystem/form_builder_extra_fields)
___

- [Features](#features)
- [Inputs](#inputs)
  - [Parameters](#parameters)
  - [Dependency parameters](#dependency-parameters)
- [Use](#use)
  - [Setup](#setup)
  - [Basic use](#basic-use)
- [Support](#support)
  - [Contribute](#contribute)
  - [Questions and answers](#questions-and-answers)
  - [Donations](#donations)
- [Roadmap](#roadmap)
- [Ecosystem](#ecosystem)
- [Thanks to](#thanks-to)
  - [Contributors](#contributors)

## Features

- Add several type of inputs to `flutter_form_builder`

## Inputs

The currently supported fields include:

- `FormBuilderChipsInput` - Takes a list of `Chip`s as input and suggests more options on typing
- `FormBuilderColorPicker` - Input for `Color` selection
- `FormBuilderCupertinoDateTimePicker` - For `Date`, `Time` and `DateTime` input using a Cupertino-style picker
- `FormBuilderRating` - For selection of a numerical value as a rating
- `FormBuilderSearchableDropdown` - Field for selecting value(s) from a searchable list
- `FormBuilderSignaturePad` - Field with drawing pad on which user can doodle
- `FormBuilderTouchSpin` - Selection of a number by tapping on a plus or minus icon
- `FormBuilderTypeAhead` - Auto-completes user input from a list of items

### Parameters

In order to create an input field in the form, along with the label, and any applicable validation, there are several attributes that are supported by all types of inputs namely:

| Attribute | Type  | Default | Required | Description |
|-----------|-------|---------|-------------|----------|
| `name` | `String` |  | `Yes` | This will form the key in the form value Map |
| `initialValue` | `T` | `null`  | `No` | The initial value of the input field |
| `enabled` | `bool` | `true` | `No` | Determines whether the field widget will accept user input. |
| `decoration` | `InputDecoration` | `InputDecoration()` | `No` | Defines the border, labels, icons, and styles used to decorate the field. |
| `validator` | `FormFieldValidator<T>` | `null` | `No` | A `FormFieldValidator` that will check the validity of value in the `FormField` |
| `onChanged` | `ValueChanged<T>` | `null` | `No` | This event function will fire immediately the the field value changes |
| `valueTransformer` | `ValueTransformer<T>` | `null` | `No` | Function that transforms field value before saving to form value. e.g. transform TextField value for numeric field from `String` to `num` |
The rest of the attributes will be determined by the type of Widget being used.

### Dependency parameters

Each field has a dependency with your own configurations. Take a look on dependencies repositories to understand the behaviour and properties:

| Field | Dependency |
|-------|------------|
|`FormBuilderChipsInput`|No dependency|
|`FormBuilderColorPicker`|[flutter_datetime_picker_bdaya](https://pub.dev/packages/flutter_datetime_picker_bdaya)|
|`FormBuilderCupertinoDateTimePicker`|[flutter_colorpicker](https://pub.dev/packages/flutter_colorpicker)|
|`FormBuilderRating`|[flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)|
|`FormBuilderSearchableDropdown`|[dropdown_search](https://pub.dev/packages/dropdown_search)|
|`FormBuilderSignaturePad`|[signature](https://pub.dev/packages/signature)|
|`FormBuilderTouchSpin`|No dependency|
|`FormBuilderTypeAhead`|[flutter_typeahead](https://pub.dev/packages/flutter_typeahead)|

## Use

### Setup

No especific setup required: only install the dependency and use :)

### Basic use

```dart
final _formKey = GlobalKey<FormBuilderState>();

FormBuilder(
    key: _formKey,
    child: FormBuilderColorPickerField(
      name: 'color_picker',
    ),
)
```

See [pub.dev example tab](https://pub.dev/packages/form_builder_extra_fields/example) or [github code](example/lib/main.dart) for more details

For more instructions about `FormBuilder`, see [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) package

## Support

### Contribute

You have some ways to contribute to this packages

- Beginner: Reporting bugs or request new features
- Intermediate: Implement new features (from issues or not) and created pull requests
- Advanced: Join to [organization](#ecosystem) like a member and help coding, manage issues, dicuss new features and other things

 See [contribution file](https://github.com/flutter-form-builder-ecosystem/.github/blob/main/CONTRIBUTING.md) for more details

### Questions and answers

You can question or search answers on [Github discussion](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/discussions) or on [StackOverflow](https://stackoverflow.com/questions/tagged/flutter-form-builder)

### Donations

Donate or become a sponsor of Flutter Form Builder Ecosystem

[![Become a Sponsor](https://opencollective.com/flutter-form-builder-ecosystem/tiers/sponsor.svg?avatarHeight=56)](https://opencollective.com/flutter-form-builder-ecosystem)

## Roadmap

- Add more widget tests and missing tests for some fields
- Remove or integrate dependencies and contribute with external dependencies
- [Add visual examples](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/issues/21) (images, gifs, videos, sample application)
- [Solve open issues](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/issues), [prioritizing bugs](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/labels/bug)

## Ecosystem

Take a look to [our awesome ecosystem](https://github.com/flutter-form-builder-ecosystem) and all packages in there

## Thanks to

### Contributors

<a href="https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=flutter-form-builder-ecosystem/form_builder_extra_fields" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
