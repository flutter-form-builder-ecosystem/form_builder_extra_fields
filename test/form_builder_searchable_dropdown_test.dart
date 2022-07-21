import 'package:flutter/widgets.dart';
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
}
