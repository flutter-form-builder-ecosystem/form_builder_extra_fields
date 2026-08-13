import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../data.dart';
import 'example_form.dart';

class SearchableDropdownExamples extends StatelessWidget {
  const SearchableDropdownExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        const Text(
          'Offline filters the local list as you type. Online waits one second, then returns matching countries.',
        ),
        const SizedBox(height: 16),
        FormBuilderSearchableDropdown<String>(
          name: 'offline',
          items: allCountries,
          popupProps: const PopupProps.menu(showSearchBox: true),
          decoration: const InputDecoration(
            labelText: 'Offline search',
            helperText: 'Open the menu and type "tur"',
          ),
          filterFn: (country, filter) =>
              country.toLowerCase().contains(filter.toLowerCase()),
        ),
        const SizedBox(height: 16),
        FormBuilderSearchableDropdown<String>(
          name: 'online',
          decoration: const InputDecoration(
            labelText: 'Online search',
            helperText: 'Same filter, with a fake 1s network delay',
          ),
          asyncItems: (filter, _) async {
            await Future<void>.delayed(const Duration(seconds: 1));
            return allCountries
                .where(
                  (country) =>
                      country.toLowerCase().contains(filter.toLowerCase()),
                )
                .toList();
          },
        ),
      ],
    );
  }
}
