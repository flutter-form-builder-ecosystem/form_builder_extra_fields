import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:material_ui/material_ui.dart' as mui;
import 'package:flutter_form_builder/flutter_form_builder.dart';

final _formKey = GlobalKey<FormBuilderState>();

Widget buildTestableFieldWidget(Widget widget) {
  return MaterialApp(
    localizationsDelegates: const [
      mui.GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en', 'US')],
    home: Scaffold(
      body: mui.Material(
        type: mui.MaterialType.transparency,
        child: FormBuilder(key: _formKey, child: widget),
      ),
    ),
  );
}

bool formSave() => _formKey.currentState!.saveAndValidate();
void formFieldDidChange(String fieldName, dynamic value) {
  _formKey.currentState!.fields[fieldName]!.didChange(value);
}

dynamic formFieldValue(String name) => _formKey.currentState!.value[name];
