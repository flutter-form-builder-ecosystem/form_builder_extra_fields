import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../data.dart';
import 'example_form.dart';

class TypeAheadExamples extends StatelessWidget {
  const TypeAheadExamples({super.key});

  List<String> _suggestions(String query) {
    if (query.isEmpty) {
      return allCountries;
    }
    final lowercaseQuery = query.toLowerCase();
    return allCountries
        .where((country) => country.toLowerCase().contains(lowercaseQuery))
        .toList(growable: false)
      ..sort(
        (a, b) => a
            .toLowerCase()
            .indexOf(lowercaseQuery)
            .compareTo(b.toLowerCase().indexOf(lowercaseQuery)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        const Text(
          'Type to filter countries. An empty query lists everything. Suggestions are sorted by the first match.',
        ),
        const SizedBox(height: 16),
        FormBuilderTypeAhead<String>(
          name: 'country',
          initialValue: 'Uganda',
          decoration: const InputDecoration(
            labelText: 'Country',
            hintText: 'Start typing a country name',
            helperText: 'Try "un" for United Kingdom / United States',
          ),
          itemBuilder: (context, country) => ListTile(title: Text(country)),
          suggestionsCallback: _suggestions,
        ),
        const SizedBox(height: 16),
        FormBuilderTypeAhead<String>(
          name: 'required_country',
          decoration: const InputDecoration(
            labelText: 'Required country',
            helperText: 'Clear this and submit to see validation',
          ),
          validator: FormBuilderValidators.required(),
          itemBuilder: (context, country) => ListTile(title: Text(country)),
          suggestionsCallback: _suggestions,
        ),
      ],
    );
  }
}
