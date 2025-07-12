import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selecting value(s) from a searchable list
class FormBuilderSearchableDropdown<T> extends FormBuilderFieldDecoration<T> {
  ///offline items list
  final List<T> items;

  ///selected item
  final T? selectedItem;

  ///selected items
  final List<T> selectedItems;

  ///called when a new items are selected
  final ValueChanged<List<T>>? onChangedMultiSelection;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize list of items UI in MultiSelection mode
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  /// style on which to base the label
  // final TextStyle? dropdownSearchBaseStyle;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? dropdownSearchTextAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? dropdownSearchTextAlignVertical;

  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  /// callback executed before applying values changes
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  ///define whatever we are in multi selection mode or single selection mode
  final bool isMultiSelectionMode;

  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? popupOnItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? popupOnItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final DropdownSearchPopupItemBuilder<T>? popupSelectionWidget;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T?>?
  popupValidationMultiSelectionWidget;

  ///widget to add custom widget like addAll/removeAll on popup multi selection mode
  final ValidationMultiSelectionBuilder<T>? popupCustomMultiSelectionWidget;

  ///function that returns item from API
  final DropdownSearchOnFind<T>? asyncItems;

  final PopupProps<T> popupProps;

  ///custom dropdown clear button icon properties
  final ClearButtonProps? clearButtonProps;

  /// style on which to base the label
  final TextStyle? dropdownSearchTextStyle;

  ///custom dropdown icon button properties
  final DropdownButtonProps? dropdownButtonProps;

  /// Creates field for selecting value(s) from a searchable list
  FormBuilderSearchableDropdown({
    super.key,
    super.autovalidateMode,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    required super.name,
    super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    this.asyncItems,
    this.autoValidateMode,
    this.compareFn,
    this.dropdownBuilder,
    this.dropdownSearchDecoration,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.filterFn,
    // this.isFilteredOnline = false,
    this.itemAsString,
    this.items = const [],
    this.onBeforeChange,
    this.popupOnItemAdded,
    this.popupOnItemRemoved,
    this.popupSelectionWidget,
    this.selectedItem,
    this.selectedItems = const [],
    this.popupProps = const PopupProps.menu(
      showSearchBox: true,
      fit: FlexFit.loose,
    ),
    this.clearButtonProps,
    this.dropdownSearchTextStyle,
    this.dropdownButtonProps,
  }) : assert(T == String || compareFn != null),
       isMultiSelectionMode = false,
       dropdownBuilderMultiSelection = null,
       onBeforeChangeMultiSelection = null,
       onSavedMultiSelection = null,
       onChangedMultiSelection = null,
       popupValidationMultiSelectionWidget = null,
       popupCustomMultiSelectionWidget = null,
       super(
         builder: (FormFieldState<T?> field) {
           final state = field as FormBuilderSearchableDropdownState<T>;
           return DropdownSearch<T>(
             compareFn: compareFn,
             enabled: state.enabled,
             dropdownBuilder: dropdownBuilder,
             suffixProps: DropdownSuffixProps(
               clearButtonProps: clearButtonProps ?? const ClearButtonProps(),
               dropdownButtonProps:
                   dropdownButtonProps ?? const DropdownButtonProps(),
             ),
             decoratorProps: DropDownDecoratorProps(
               decoration: state.decoration,
               textAlign: dropdownSearchTextAlign,
               textAlignVertical: dropdownSearchTextAlignVertical,
               baseStyle: dropdownSearchTextStyle,
             ),
             filterFn: filterFn,
             items: (filter, infiniteScrollProps) => asyncItems == null
                 ? items
                 : asyncItems(filter, infiniteScrollProps),
             itemAsString: itemAsString,
             onBeforeChange: onBeforeChange,
             onChanged: (value) {
               state.didChange(value);
             },
             popupProps: popupProps,
             selectedItem: state.value,
           );
         },
       );

  @override
  FormBuilderSearchableDropdownState<T> createState() =>
      FormBuilderSearchableDropdownState<T>();
}

class FormBuilderSearchableDropdownState<T>
    extends
        FormBuilderFieldDecorationState<FormBuilderSearchableDropdown<T>, T> {}
