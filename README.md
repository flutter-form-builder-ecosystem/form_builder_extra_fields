# Form Builder Extra Fields

FormBuilder Extra Fields provides common ready-made form input fields for [`flutter_form_builder` package](https://pub.dev/packages/flutter_form_builder). The package gives you a convenient way of adding common ready-made input fields instead of creating your own FormBuilderField from scratch.
___

[![Pub Version](https://img.shields.io/pub/v/form_builder_extra_fields?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_extra_fields)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/flutter-form-builder-ecosystem/form_builder_extra_fields/Base?logo=github&style=for-the-badge)](https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/actions/workflows/base.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/flutter-form-builder-ecosystem/form_builder_extra_fields?logo=codecov&style=for-the-badge)](https://codecov.io/gh/flutter-form-builder-ecosystem/form_builder_extra_fields/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/flutter-form-builder-ecosystem/form_builder_extra_fields?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/flutter-form-builder-ecosystem/form_builder_extra_fields)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-1.svg)](https://www.buymeacoffee.com/danvick)

___


### Example

```dart
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

...

final _formKey = GlobalKey<FormBuilderState>();
final continents = ['Africa', 'Asia', 'Australia', 'Europe', 'North America', 'South America'];
...


@override
Widget build(BuildContext context) {
  return FormBuilder(
    key: _formKey,
    autovalidate: true,
    child: Column(
      children: <Widget>[
        FormBuilderSearchableDropdown(
          name: 'searchable_dropdown',
          items: continents,
          decoration:
              const InputDecoration(labelText: 'Searchable Dropdown'),
        ),
        const SizedBox(height: 15),
        FormBuilderColorPickerField(
          name: 'color_picker',
          initialValue: Colors.yellow,
          // readOnly: true,
          colorPickerType: ColorPickerType.MaterialPicker,
          decoration: const InputDecoration(labelText: 'Color Picker'),
        ),
        FormBuilderCupertinoDateTimePicker(
          name: 'date_time',
          initialValue: DateTime.now(),
          inputType: CupertinoDateTimePickerInputType.both,
          decoration: const InputDecoration(
            labelText: 'Cupertino DateTime Picker',
          ),
          locale: Locale.fromSubtags(languageCode: 'en_GB'),
        ),
        FormBuilderCupertinoDateTimePicker(
          name: 'date',
          initialValue: DateTime.now(),
          inputType: CupertinoDateTimePickerInputType.date,
          decoration: const InputDecoration(
            labelText: 'Cupertino DateTime Picker - Date Only',
          ),
          locale: Locale.fromSubtags(languageCode: 'en_GB'),
        ),
        FormBuilderCupertinoDateTimePicker(
          name: 'time',
          initialValue: DateTime.now(),
          inputType: CupertinoDateTimePickerInputType.time,
          decoration: const InputDecoration(
            labelText: 'Cupertino DateTime Picker - Time Only',
          ),
          locale: Locale.fromSubtags(languageCode: 'en_GB'),
        ),
        FormBuilderTypeAhead<String>(
          decoration: const InputDecoration(
              labelText: 'TypeAhead (Autocomplete TextField)',
              hintText: 'Start typing continent name'),
          name: 'continent',
          itemBuilder: (context, continent) {
            return ListTile(title: Text(continent));
          },
          suggestionsCallback: (query) {
            if (query.isNotEmpty) {
              var lowercaseQuery = query.toLowerCase();
              return continents.where((continent) {
                return continent.toLowerCase().contains(lowercaseQuery);
              }).toList(growable: false)
                ..sort((a, b) => a
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(
                        b.toLowerCase().indexOf(lowercaseQuery)));
            } else {
              return continents;
            }
          },
        ),
        FormBuilderTouchSpin(
          decoration: const InputDecoration(labelText: 'TouchSpin'),
          name: 'touch_spin',
          initialValue: 10,
          step: 1,
          iconSize: 48.0,
          addIcon: const Icon(Icons.arrow_right),
          subtractIcon: const Icon(Icons.arrow_left),
          
        ),
        FormBuilderRating(
          decoration: const InputDecoration(labelText: 'Rating'),
          name: 'rate',
          iconSize: 32.0,
          initialValue: 1.0,
          max: 5.0,
        ),
        FormBuilderSignaturePad(
          decoration: const InputDecoration(
            labelText: 'Signature Pad',
          ),
          name: 'signature',
          border: Border.all(color: Colors.green),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState.save();
                  if (_formKey.currentState.validate()) {
                    print(_formKey.currentState.value);
                  } else {
                    print("validation failed");
                  }
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState.reset();
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
```

## Input widgets

The currently supported fields include:
* `FormBuilderChipsInput` - Takes a list of `Chip`s as input and suggests more options on typing
* `FormBuilderColorPicker` - For `Color` input selection
* `FormBuilderCupertinoDateTimePicker` - For `Date`, `Time` and `DateTime` input using a Cupertino-style picker
* `FormBuilderRating` - For selection of a numerical value as a rating
* `FormBuilderSearchableDropdown` - Field for selecting value(s) from a searchable list
* `FormBuilderSignaturePad` - Field with drawing pad on which user can doodle
* `FormBuilderTouchSpin` - Selection of a number by tapping on a plus or minus icon
* `FormBuilderTypeAhead` - Auto-completes user input from a list of items


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

## Support

### Issues and PRs

Any kind of support in the form of reporting bugs, answering questions or PRs is always appreciated.

### Coffee :-)

If this package was helpful to you in delivering your project or you just wanna to support this
package, a cup of coffee would be highly appreciated ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-1.svg)](https://www.buymeacoffee.com/danvick)

## Credits

<a href="https://github.com/flutter-form-builder-ecosystem/form_builder_extra_fields/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=flutter-form-builder-ecosystem/form_builder_extra_fields" />
</a>

Made with [contrib.rocks](https://contrib.rocks).