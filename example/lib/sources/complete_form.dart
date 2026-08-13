import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../data.dart';

class CompleteForm extends StatefulWidget {
  const CompleteForm({super.key});

  @override
  State<CompleteForm> createState() => _CompleteFormState();
}

class _CompleteFormState extends State<CompleteForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState?.save();
          debugPrint(_formKey.currentState?.value.toString());
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            FormBuilderSearchableDropdown<String>(
              name: 'searchable_dropdown_online',
              onChanged: _onChanged,
              asyncItems: (filter, _) async {
                await Future.delayed(const Duration(seconds: 1));
                return allCountries
                    .where(
                      (element) =>
                          element.toLowerCase().contains(filter.toLowerCase()),
                    )
                    .toList();
              },
              decoration: const InputDecoration(
                labelText: 'Searchable Dropdown Online',
              ),
            ),
            FormBuilderSearchableDropdown<String>(
              popupProps: const PopupProps.menu(showSearchBox: true),
              dropdownSearchDecoration: const InputDecoration(
                hintText: 'Search',
                labelText: 'Search',
              ),
              name: 'searchable_dropdown_offline',
              items: allCountries,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                labelText: 'Searchable Dropdown Offline',
              ),
              filterFn: (country, filter) =>
                  country.toLowerCase().contains(filter.toLowerCase()),
            ),
            const SizedBox(height: 15),
            FormBuilderSearchableMultiSelectDropdown<String>(
              name: 'multiselect_dropdown_offline',
              items: allCountries,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                labelText: 'Multiselect Dropdown Offline',
              ),
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
                fit: FlexFit.loose,
              ),
              filterFn: (country, filter) =>
                  country.toLowerCase().contains(filter.toLowerCase()),
            ),
            const SizedBox(height: 15),
            FormBuilderSearchableMultiSelectDropdown<String>(
              name: 'multiselect_dropdown_online',
              onChanged: _onChanged,
              asyncItems: (filter, _) async {
                await Future.delayed(const Duration(seconds: 1));
                return allCountries
                    .where(
                      (element) =>
                          element.toLowerCase().contains(filter.toLowerCase()),
                    )
                    .toList();
              },
              decoration: const InputDecoration(
                labelText: 'Multiselect Dropdown Online',
              ),
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
                fit: FlexFit.loose,
              ),
            ),
            const SizedBox(height: 15),
            FormBuilderColorPickerField(
              name: 'color_picker',
              initialValue: Colors.yellow,
              colorPickerType: ColorPickerType.materialPicker,
              decoration: const InputDecoration(labelText: 'Color Picker'),
            ),
            FormBuilderTypeAhead<String>(
              decoration: const InputDecoration(
                labelText: 'TypeAhead (Autocomplete TextField)',
                hintText: 'Start typing country name',
              ),
              name: 'country',
              onChanged: _onChanged,
              itemBuilder: (context, country) {
                return ListTile(title: Text(country));
              },
              initialValue: 'Uganda',
              suggestionsCallback: (query) {
                if (query.isNotEmpty) {
                  var lowercaseQuery = query.toLowerCase();
                  return allCountries
                      .where((country) {
                        return country.toLowerCase().contains(lowercaseQuery);
                      })
                      .toList(growable: false)
                    ..sort(
                      (a, b) => a
                          .toLowerCase()
                          .indexOf(lowercaseQuery)
                          .compareTo(b.toLowerCase().indexOf(lowercaseQuery)),
                    );
                } else {
                  return allCountries;
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
              onChanged: _onChanged,
            ),
            FormBuilderRatingBar(
              decoration: const InputDecoration(labelText: 'Rating Bar'),
              name: 'rate',
              itemSize: 32.0,
              initialValue: 1.0,
              maxRating: 5.0,
              onChanged: _onChanged,
            ),
            FormBuilderSignaturePad(
              decoration: const InputDecoration(labelText: 'Signature Pad'),
              name: 'signature',
              border: Border.all(color: Colors.green),
              onChanged: _onChanged,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState?.value.toString());
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
