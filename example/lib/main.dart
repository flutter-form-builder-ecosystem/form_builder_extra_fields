import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:material_ui/material_ui.dart'
    hide GlobalMaterialLocalizations;
import 'package:form_builder_validators/form_builder_validators.dart';

import 'code_page.dart';
import 'sources/color_picker.dart';
import 'sources/complete_form.dart';
import 'sources/rating_bar.dart';
import 'sources/searchable_dropdown.dart';
import 'sources/searchable_multiselect.dart';
import 'sources/signature_pad.dart';
import 'sources/touch_spin.dart';
import 'sources/typeahead.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Extra Fields',
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return CodePage(
      title: 'Extra Fields Example',
      child: ListView(
        children: [
          _ExampleTile(
            title: 'Complete form',
            subtitle: 'Every extra field on one form, same as before',
            page: const CompleteForm(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'Color picker',
            subtitle: 'Material, HSV, and block pickers, plus a disabled field',
            page: const ColorPickerExamples(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'Searchable dropdown',
            subtitle: 'Offline filter vs a delayed online lookup',
            page: const SearchableDropdownExamples(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'Searchable multiselect',
            subtitle: 'Same search, but the value is a list',
            page: const SearchableMultiSelectExamples(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'TypeAhead',
            subtitle: 'Autocomplete from a country list, including validation',
            page: const TypeAheadExamples(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'TouchSpin',
            subtitle: 'Step size, min/max, and a disabled control',
            page: const TouchSpinExamples(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'Rating bar',
            subtitle: 'Whole stars, half stars, and a read-only rating',
            page: const RatingBarExamples(),
          ),
          const Divider(),
          _ExampleTile(
            title: 'Signature pad',
            subtitle: 'Draw a signature and see the saved PNG size',
            page: const SignaturePadExamples(),
          ),
        ],
      ),
    );
  }
}

class _ExampleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget page;

  const _ExampleTile({
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_right_sharp),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CodePage(title: title, child: page),
          ),
        );
      },
    );
  }
}
