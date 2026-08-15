import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_extra_fields/src/fields/form_builder_searchable_dropdown.dart';

import 'form_builder_tester.dart';

void main() {
  const options = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven'];
  const initialTextValue = 'One';
  const newTextValue = 'Two';
  const textFieldName = 'dropdown';
  final testWidgetKey = GlobalKey<FormBuilderFieldState>();
  String? result;

  setUp(() => result = null);

  testWidgets('FormBuilderSearchableDropdown', (WidgetTester tester) async {
    final testWidget = FormBuilderSearchableDropdown<String>(
      key: testWidgetKey,
      name: textFieldName,
      initialValue: initialTextValue,
      items: options,
      dropdownBuilder: (_, country) => Text.rich(TextSpan(text: country)),
      onChanged: (query) => result = query,
    );

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));
    expect(result, isNull);
    expect(formSave(), isTrue);
    expect(formFieldValue(textFieldName), initialTextValue);

    testWidgetKey.currentState?.didChange(options.last);
    expect(result, options.last);

    final itemToSelect = find.text(newTextValue);
    expect(itemToSelect, findsNothing);

    final initialItem = find.text(initialTextValue);
    expect(initialItem, findsOneWidget);

    await tester.tap(initialItem);
    await tester.pumpAndSettle();

    expect(initialItem, findsOneWidget);
    expect(itemToSelect, findsOneWidget);

    await tester.tap(itemToSelect);
    await tester.pumpAndSettle();

    expect(result, newTextValue);

    expect(formSave(), isTrue);
    expect(formFieldValue(textFieldName), equals(newTextValue));

    testWidgetKey.currentState!.didChange(null);
    expect(formSave(), isTrue);
    expect(formFieldValue(textFieldName), isNull);
    expect(result, isNull);
  });

  testWidgets('defaults selected value style to Theme.textTheme.titleMedium', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildTestableFieldWidget(
        FormBuilderSearchableDropdown<String>(
          name: textFieldName,
          initialValue: initialTextValue,
          items: options,
        ),
      ),
    );

    final dropdown = tester.widget<DropdownSearch<String>>(
      find.byType(DropdownSearch<String>),
    );
    final theme = Theme.of(
      tester.element(find.byType(FormBuilderSearchableDropdown<String>)),
    );
    expect(dropdown.decoratorProps.baseStyle, theme.textTheme.titleMedium);
  });
}
