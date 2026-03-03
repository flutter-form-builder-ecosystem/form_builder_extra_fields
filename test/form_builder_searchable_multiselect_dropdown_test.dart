import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_extra_fields/src/fields/form_builder_searchable_multiselect_dropdown.dart';

import 'form_builder_tester.dart';

void main() {
  const options = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven'];
  const fieldName = 'multiselect_dropdown';

  /// Builds the widget-under-test with sensible defaults that can be overridden.
  Widget buildWidget({
    GlobalKey<FormBuilderFieldState>? fieldKey,
    List<String> initialValue = const [],
    ValueChanged<List<String>?>? onChanged,
    bool enabled = true,
    String? Function(List<String>?)? validator,
    DropdownSearchBuilder<List<String>>? dropdownBuilder,
    PopupPropsMultiSelection<String> popupProps =
        const PopupPropsMultiSelection.menu(
          showSearchBox: true,
          fit: FlexFit.loose,
        ),
    DropdownSearchOnFind<String>? asyncItems,
    BeforeChange<List<String>>? onBeforeChange,
  }) {
    return FormBuilderSearchableMultiSelectDropdown<String>(
      key: fieldKey,
      name: fieldName,
      initialValue: initialValue,
      items: options,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
      dropdownBuilder: dropdownBuilder,
      popupProps: popupProps,
      asyncItems: asyncItems,
      onBeforeChange: onBeforeChange,
    );
  }

  group('FormBuilderSearchableMultiSelectDropdown', () {
    group('initial value', () {
      testWidgets('preserves initial values on form save', (tester) async {
        await tester.pumpWidget(
          buildTestableFieldWidget(buildWidget(initialValue: ['One', 'Two'])),
        );

        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), equals(['One', 'Two']));
      });

      testWidgets('starts with empty list when no initial value is given', (
        tester,
      ) async {
        await tester.pumpWidget(buildTestableFieldWidget(buildWidget()));

        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), isEmpty);
      });
    });

    group('programmatic changes', () {
      testWidgets('didChange updates form value and fires onChanged', (
        tester,
      ) async {
        final key = GlobalKey<FormBuilderFieldState>();
        List<String>? changedValue;

        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(fieldKey: key, onChanged: (v) => changedValue = v),
          ),
        );

        key.currentState!.didChange(['Three', 'Four']);

        expect(changedValue, equals(['Three', 'Four']));
        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), equals(['Three', 'Four']));
      });

      testWidgets('didChange to null clears selection and fires onChanged', (
        tester,
      ) async {
        final key = GlobalKey<FormBuilderFieldState>();
        List<String>? changedValue = ['One'];

        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(
              fieldKey: key,
              initialValue: ['One'],
              onChanged: (v) => changedValue = v,
            ),
          ),
        );

        key.currentState!.didChange(null);

        expect(changedValue, isNull);
        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), isNull);
      });

      testWidgets('reset restores initial value after programmatic change', (
        tester,
      ) async {
        final key = GlobalKey<FormBuilderFieldState>();

        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(fieldKey: key, initialValue: ['One', 'Two']),
          ),
        );

        key.currentState!.didChange(['Seven']);
        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), equals(['Seven']));

        key.currentState!.reset();
        await tester.pumpAndSettle();

        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), equals(['One', 'Two']));
      });
    });

    group('validation', () {
      testWidgets(
        'fails when selection is empty and validator requires items',
        (tester) async {
          const errorMessage = 'Please select at least one item';

          await tester.pumpWidget(
            buildTestableFieldWidget(
              buildWidget(
                validator: (value) =>
                    (value == null || value.isEmpty) ? errorMessage : null,
              ),
            ),
          );

          expect(formSave(), isFalse);
          await tester.pump(); // allow error text widget to rebuild
          expect(find.text(errorMessage), findsOneWidget);
        },
      );

      testWidgets('passes when at least one item is selected', (tester) async {
        const errorMessage = 'Please select at least one item';
        final key = GlobalKey<FormBuilderFieldState>();

        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(
              fieldKey: key,
              validator: (value) =>
                  (value == null || value.isEmpty) ? errorMessage : null,
            ),
          ),
        );

        key.currentState!.didChange(['One']);

        expect(formSave(), isTrue);
        expect(find.text(errorMessage), findsNothing);
      });
    });

    group('UI interaction', () {
      testWidgets(
        'selecting items in popup and confirming updates form value',
        (tester) async {
          final key = GlobalKey<FormBuilderFieldState>();
          List<String>? changedValue;

          await tester.pumpWidget(
            buildTestableFieldWidget(
              buildWidget(fieldKey: key, onChanged: (v) => changedValue = v),
            ),
          );

          // Open the drop-down popup.
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          final listFinder = find.byType(Scrollable).last;

          for (final item in ['One', 'Three']) {
            final itemFinder = find.text(item);
            await tester.scrollUntilVisible(
              itemFinder,
              500,
              scrollable: listFinder,
            );
            await tester.tap(itemFinder, warnIfMissed: false);
            await tester.pumpAndSettle();
          }

          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();

          expect(changedValue, equals(['One', 'Three']));
          expect(formSave(), isTrue);
          expect(formFieldValue(fieldName), equals(['One', 'Three']));
        },
      );

      testWidgets(
        'deselecting a pre-selected item in popup removes it from the result',
        (tester) async {
          final key = GlobalKey<FormBuilderFieldState>();
          List<String>? changedValue;

          await tester.pumpWidget(
            buildTestableFieldWidget(
              buildWidget(
                fieldKey: key,
                initialValue: ['One', 'Two'],
                onChanged: (v) => changedValue = v,
              ),
            ),
          );

          // Open the drop-down popup.
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          final listFinder = find.byType(Scrollable).last;

          // Tap 'One' to deselect it (it starts checked).
          // Scope to the popup ListView to avoid matching the 'One' chip in the
          // collapsed dropdown.  The text is inside IgnorePointer (CheckBoxWidget
          // design), so we do NOT use .hitTestable(); tester.tap sends the event
          // at the widget's screen position and the InkResponse ancestor handles it.
          final popupListView = find.byType(ListView).last;
          final oneFinder = find.descendant(
            of: popupListView,
            matching: find.text('One'),
          );
          await tester.scrollUntilVisible(
            oneFinder,
            500,
            scrollable: listFinder,
          );
          await tester.tap(oneFinder, warnIfMissed: false);
          await tester.pumpAndSettle();

          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();

          // Only 'Two' should remain.
          expect(changedValue, equals(['Two']));
          expect(formSave(), isTrue);
          expect(formFieldValue(fieldName), equals(['Two']));
        },
      );

      testWidgets('search box filters the visible items', (tester) async {
        final key = GlobalKey<FormBuilderFieldState>();

        // Use searchDelay: Duration.zero so the debounce fires immediately and
        // pumpAndSettle() can process the async items reload without worrying
        // about pending timers at teardown.
        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(
              fieldKey: key,
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
                fit: FlexFit.loose,
                searchDelay: Duration.zero,
              ),
            ),
          ),
        );

        // Open the drop-down popup.
        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final popupListView = find.byType(ListView).last;

        // Multiple items are visible before filtering.
        expect(
          find.descendant(of: popupListView, matching: find.text('One')),
          findsOneWidget,
        );
        expect(
          find.descendant(of: popupListView, matching: find.text('Two')),
          findsOneWidget,
        );

        // Type a search query that matches only 'Three'.
        final searchField = find.byType(TextField).last;
        await tester.enterText(searchField, 'Thr');
        // Timer(Duration.zero) fires on the next microtask; pumpAndSettle
        // advances through it and the subsequent async items reload.
        await tester.pumpAndSettle();

        expect(
          find.descendant(of: popupListView, matching: find.text('Three')),
          findsOneWidget,
        );
        expect(
          find.descendant(of: popupListView, matching: find.text('One')),
          findsNothing,
        );
        expect(
          find.descendant(of: popupListView, matching: find.text('Two')),
          findsNothing,
        );

        // Close the popup cleanly so no timers remain pending at teardown.
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
      });
    });

    group('disabled state', () {
      testWidgets('does not open popup when disabled', (tester) async {
        final key = GlobalKey<FormBuilderFieldState>();

        await tester.pumpWidget(
          buildTestableFieldWidget(buildWidget(fieldKey: key, enabled: false)),
        );

        await tester.tap(find.byKey(key), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(find.byType(ListView), findsNothing);
      });
    });

    group('async items', () {
      testWidgets('loads and displays items from asyncItems callback', (
        tester,
      ) async {
        final key = GlobalKey<FormBuilderFieldState>();

        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(
              fieldKey: key,
              asyncItems: (filter, _) async => ['Alpha', 'Beta', 'Gamma'],
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: false,
                fit: FlexFit.loose,
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final popupListView = find.byType(ListView).last;
        expect(
          find.descendant(of: popupListView, matching: find.text('Alpha')),
          findsOneWidget,
        );
        expect(
          find.descendant(of: popupListView, matching: find.text('Beta')),
          findsOneWidget,
        );
        expect(
          find.descendant(of: popupListView, matching: find.text('Gamma')),
          findsOneWidget,
        );

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
      });
    });

    group('onBeforeChange', () {
      testWidgets('rejecting onBeforeChange prevents form value update', (
        tester,
      ) async {
        final key = GlobalKey<FormBuilderFieldState>();

        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(
              fieldKey: key,
              onBeforeChange: (prev, next) async => false,
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final listFinder = find.byType(Scrollable).last;
        final itemFinder = find.text('One');
        await tester.scrollUntilVisible(
          itemFinder,
          500,
          scrollable: listFinder,
        );
        await tester.tap(itemFinder, warnIfMissed: false);
        await tester.pumpAndSettle();

        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(formSave(), isTrue);
        expect(formFieldValue(fieldName), isEmpty);
      });
    });

    group('custom dropdownBuilder', () {
      testWidgets('renders custom widget for selected items', (tester) async {
        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(
              initialValue: ['One'],
              dropdownBuilder: _customDropdownBuilder,
            ),
          ),
        );

        expect(find.text('One'), findsOneWidget);
      });

      testWidgets('renders placeholder when no items are selected', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestableFieldWidget(
            buildWidget(dropdownBuilder: _customDropdownBuilder),
          ),
        );

        expect(find.text('No item selected'), findsOneWidget);
      });
    });
  });
}

Widget _customDropdownBuilder(
  BuildContext context,
  List<String>? selectedItems,
) {
  if (selectedItems == null || selectedItems.isEmpty) {
    return const ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(),
      title: Text('No item selected'),
    );
  }

  return Wrap(
    children: selectedItems
        .map(
          (item) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(contentPadding: EdgeInsets.zero, title: Text(item)),
          ),
        )
        .toList(),
  );
}
