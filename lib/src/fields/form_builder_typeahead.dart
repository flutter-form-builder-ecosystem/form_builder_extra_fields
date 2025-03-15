import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef SelectionToTextTransformer<T> = String Function(T suggestion);

/// Text field that auto-completes user input from a list of items
class FormBuilderTypeAhead<T> extends FormBuilderFieldDecoration<T> {
  final FutureOr<List<T>?> Function(String) suggestionsCallback;
  final void Function(T)? onSelected;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(BuildContext, Widget)? decorationBuilder;
  final SuggestionsController<T>? suggestionsController;
  final Duration debounceDuration;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? emptyBuilder;
  final Widget Function(BuildContext context, Object error)?
  suggestionErrorBuilder;
  final Widget Function(BuildContext, Animation<double>, Widget)?
  transitionBuilder;
  final Duration animationDuration;
  final VerticalDirection? direction;

  /// Custom text field to use instead of the default [TextField]
  ///
  /// When use this parameter, FormBuilderTypeAhead will be override the
  /// following properties:
  ///
  /// - enabled
  /// - decoration
  /// - controller
  /// - focusNode
  /// - style.disabled
  final TextField? customTextField;
  final Offset? offset;
  final bool hideOnLoading;
  final bool hideOnEmpty;
  final bool hideOnError;
  final bool hideWithKeyboard;
  final bool retainOnLoading;
  final bool hideOnSelect;
  final bool autoFlipDirection;
  final SelectionToTextTransformer<T>? selectionToTextTransformer;
  final TextEditingController? controller;
  final bool hideOnUnfocus;
  final ScrollController? scrollController;
  final IndexedWidgetBuilder? itemSeparatorBuilder;
  final Widget Function(BuildContext, List<Widget>)? listBuilder;
  final bool autoFlipListDirection;
  final double autoFlipMinHeight;
  final bool hideKeyboardOnDrag;
  final bool showOnFocus;
  final BoxConstraints? constraints;

  FormBuilderTypeAhead({
    super.key,
    super.autovalidateMode,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    required super.name,
    required this.itemBuilder,
    required this.suggestionsCallback,
    this.animationDuration = const Duration(milliseconds: 500),
    this.autoFlipDirection = false,
    this.controller,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.direction,
    this.suggestionErrorBuilder,
    this.hideOnUnfocus = true,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideOnLoading = false,
    this.hideWithKeyboard = true,
    this.retainOnLoading = true,
    this.hideOnSelect = true,
    this.loadingBuilder,
    this.emptyBuilder,
    this.onSelected,
    this.scrollController,
    this.selectionToTextTransformer,
    this.suggestionsController,
    this.decorationBuilder,
    this.offset,
    this.customTextField,
    this.transitionBuilder,
    this.autoFlipListDirection = true,
    this.autoFlipMinHeight = 64.0,
    this.hideKeyboardOnDrag = false,
    this.itemSeparatorBuilder,
    this.listBuilder,
    this.showOnFocus = true,
    this.constraints,
  }) : assert(T == String || selectionToTextTransformer != null),
       super(
         builder: (FormFieldState<T?> field) {
           final state = field as FormBuilderTypeAheadState<T>;
           final theme = Theme.of(state.context);

           return TypeAheadField<T>(
             controller: state._typeAheadController,
             focusNode: state.effectiveFocusNode,
             showOnFocus: showOnFocus,
             constraints: constraints,
             builder: (context, controller, focusNode) {
               return customTextField != null
                   ? customTextField.copyWith(
                     enabled: state.enabled,
                     controller: controller,
                     focusNode: focusNode,
                     decoration: state.decoration,
                     style:
                         state.enabled
                             ? customTextField.style
                             : theme.textTheme.titleMedium!.copyWith(
                               color: theme.disabledColor,
                             ),
                   )
                   : TextField(
                     enabled: state.enabled,
                     controller: controller,
                     focusNode: focusNode,
                     decoration: state.decoration,
                     style:
                         state.enabled
                             ? theme.textTheme.titleMedium
                             : theme.textTheme.titleMedium!.copyWith(
                               color: theme.disabledColor,
                             ),
                   );
             },
             autoFlipMinHeight: autoFlipMinHeight,
             hideKeyboardOnDrag: hideKeyboardOnDrag,
             itemSeparatorBuilder: itemSeparatorBuilder,
             listBuilder: listBuilder,
             suggestionsCallback: suggestionsCallback,
             itemBuilder: itemBuilder,
             transitionBuilder: (context, animation, child) => child,
             onSelected: (T suggestion) {
               state.didChange(suggestion);
               onSelected?.call(suggestion);
             },
             errorBuilder: suggestionErrorBuilder,
             emptyBuilder: emptyBuilder,
             loadingBuilder: loadingBuilder,
             debounceDuration: debounceDuration,
             decorationBuilder: decorationBuilder,
             offset: offset,
             animationDuration: animationDuration,
             direction: direction,
             hideOnLoading: hideOnLoading,
             hideOnEmpty: hideOnEmpty,
             hideOnError: hideOnError,
             hideWithKeyboard: hideWithKeyboard,
             retainOnLoading: retainOnLoading,
             autoFlipDirection: autoFlipDirection,
             suggestionsController: suggestionsController,
             hideOnSelect: hideOnSelect,
             hideOnUnfocus: hideOnUnfocus,
             scrollController: scrollController,
           );
         },
       );

  @override
  FormBuilderTypeAheadState<T> createState() => FormBuilderTypeAheadState<T>();
}

class FormBuilderTypeAheadState<T>
    extends FormBuilderFieldDecorationState<FormBuilderTypeAhead<T>, T> {
  late TextEditingController _typeAheadController;

  @override
  void initState() {
    super.initState();
    _typeAheadController =
        widget.controller ??
        TextEditingController(text: _getTextString(initialValue));
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    var text = _getTextString(value);

    if (_typeAheadController.text != text) {
      _typeAheadController.text = text;
    }
  }

  @override
  void dispose() {
    // Dispose the _typeAheadController when initState created it
    super.dispose();
    _typeAheadController.dispose();
  }

  @override
  void reset() {
    super.reset();

    _typeAheadController.text = _getTextString(initialValue);
  }

  String _getTextString(T? value) {
    var text =
        value == null
            ? ''
            : widget.selectionToTextTransformer != null
            ? widget.selectionToTextTransformer!(value)
            : value.toString();

    return text;
  }
}

extension TextFiledCopy on TextField {
  TextField copyWith({
    TextEditingController? controller,
    TextStyle? style,
    InputDecoration? decoration,
    FocusNode? focusNode,
    bool? enabled,
  }) {
    return TextField(
      controller: controller ?? this.controller,
      style: style ?? this.style,
      decoration: decoration ?? this.decoration,
      focusNode: focusNode ?? this.focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      readOnly: readOnly,
      showCursor: showCursor,
      autofocus: autofocus,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled ?? this.enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: onTap,
      buildCounter: buildCounter,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      restorationId: restorationId,
      canRequestFocus: canRequestFocus,
      clipBehavior: clipBehavior,
      contentInsertionConfiguration: contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder,
      cursorErrorColor: cursorErrorColor,
      cursorOpacityAnimates: cursorOpacityAnimates,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      groupId: groupId,
      ignorePointers: ignorePointers,
      mouseCursor: mouseCursor,
      obscuringCharacter: obscuringCharacter,
      key: key,
      magnifierConfiguration: magnifierConfiguration,
      selectionControls: selectionControls,
      onAppPrivateCommand: onAppPrivateCommand,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onTapOutside: onTapOutside,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      spellCheckConfiguration: spellCheckConfiguration,
      statesController: statesController,
      strutStyle: strutStyle,
      undoController: undoController,
    );
  }
}
