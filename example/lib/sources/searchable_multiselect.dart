import 'package:material_ui/material_ui.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../data.dart';
import 'example_form.dart';

class SearchableMultiSelectExamples extends StatelessWidget {
  const SearchableMultiSelectExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        const Text(
          'Pick more than one country. The form value is a List<String>.',
        ),
        const SizedBox(height: 16),
        FormBuilderSearchableMultiSelectDropdown<String>(
          name: 'offline',
          items: allCountries,
          decoration: const InputDecoration(
            labelText: 'Offline multiselect',
            helperText: 'Search, then tick several countries',
          ),
          popupProps: const MultiSelectionPopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,
          ),
          filterFn: (country, filter) =>
              country.toLowerCase().contains(filter.toLowerCase()),
        ),
        const SizedBox(height: 16),
        FormBuilderSearchableMultiSelectDropdown<String>(
          name: 'online',
          decoration: const InputDecoration(
            labelText: 'Online multiselect',
            helperText: 'Same picker after a 1s delay',
          ),
          popupProps: const MultiSelectionPopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,
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
