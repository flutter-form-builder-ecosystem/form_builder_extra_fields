import 'package:flutter/material.dart' as flutter_material;
import 'package:material_ui/material_ui.dart' as material_ui;

/// Converts a [material_ui.InputDecoration] to a
/// [flutter_material.InputDecoration].
///
/// This is needed because `material_ui` (used by `flutter_form_builder`) and
/// `flutter/material.dart` (used by `dropdown_search`) provide distinct
/// [InputDecoration] classes that are not interchangeable at the type level,
/// even though they share the same API surface.
flutter_material.InputDecoration convertInputDecoration(
  material_ui.InputDecoration d,
) {
  return flutter_material.InputDecoration(
    alignLabelWithHint: d.alignLabelWithHint,
    border: _convertInputBorder(d.border),
    constraints: d.constraints,
    contentPadding: d.contentPadding,
    counter: d.counter,
    counterStyle: d.counterStyle,
    counterText: d.counterText,
    disabledBorder: _convertInputBorder(d.disabledBorder),
    enabled: d.enabled,
    enabledBorder: _convertInputBorder(d.enabledBorder),
    error: d.error,
    errorBorder: _convertInputBorder(d.errorBorder),
    errorMaxLines: d.errorMaxLines,
    errorStyle: d.errorStyle,
    errorText: d.errorText,
    fillColor: d.fillColor,
    filled: d.filled,
    floatingLabelAlignment: _convertFloatingLabelAlignment(
      d.floatingLabelAlignment,
    ),
    floatingLabelBehavior: _convertFloatingLabelBehavior(
      d.floatingLabelBehavior,
    ),
    floatingLabelStyle: d.floatingLabelStyle,
    focusColor: d.focusColor,
    focusedBorder: _convertInputBorder(d.focusedBorder),
    focusedErrorBorder: _convertInputBorder(d.focusedErrorBorder),
    helper: d.helper,
    helperMaxLines: d.helperMaxLines,
    helperStyle: d.helperStyle,
    helperText: d.helperText,
    hint: d.hint,
    hintFadeDuration: d.hintFadeDuration,
    hintMaxLines: d.hintMaxLines,
    hintText: d.hintText,
    hintTextDirection: d.hintTextDirection,
    hintStyle: d.hintStyle,
    hoverColor: d.hoverColor,
    icon: d.icon,
    iconColor: d.iconColor,
    isCollapsed: d.isCollapsed,
    isDense: d.isDense,
    label: d.label,
    labelText: d.labelText,
    labelStyle: d.labelStyle,
    prefix: d.prefix,
    prefixIcon: d.prefixIcon,
    prefixIconColor: d.prefixIconColor,
    prefixIconConstraints: d.prefixIconConstraints,
    prefixStyle: d.prefixStyle,
    prefixText: d.prefixText,
    semanticCounterText: d.semanticCounterText,
    suffix: d.suffix,
    suffixIcon: d.suffixIcon,
    suffixIconColor: d.suffixIconColor,
    suffixIconConstraints: d.suffixIconConstraints,
    suffixStyle: d.suffixStyle,
    suffixText: d.suffixText,
    visualDensity: _convertVisualDensity(d.visualDensity),
  );
}

flutter_material.InputBorder? _convertInputBorder(
  material_ui.InputBorder? border,
) {
  if (border == null) return null;
  if (border is material_ui.UnderlineInputBorder) {
    return flutter_material.UnderlineInputBorder(
      borderSide: _convertBorderSide(border.borderSide),
      borderRadius: border.borderRadius,
    );
  }
  if (border is material_ui.OutlineInputBorder) {
    return flutter_material.OutlineInputBorder(
      borderSide: _convertBorderSide(border.borderSide),
      borderRadius: border.borderRadius,
      gapPadding: border.gapPadding,
    );
  }
  return flutter_material.InputBorder.none;
}

flutter_material.BorderSide _convertBorderSide(material_ui.BorderSide side) {
  return flutter_material.BorderSide(
    color: side.color,
    width: side.width,
    style: side.style,
    strokeAlign: side.strokeAlign,
  );
}

flutter_material.FloatingLabelAlignment? _convertFloatingLabelAlignment(
  material_ui.FloatingLabelAlignment? alignment,
) {
  if (alignment == null) return null;
  if (alignment == material_ui.FloatingLabelAlignment.start) {
    return flutter_material.FloatingLabelAlignment.start;
  }
  return flutter_material.FloatingLabelAlignment.center;
}

flutter_material.FloatingLabelBehavior? _convertFloatingLabelBehavior(
  material_ui.FloatingLabelBehavior? behavior,
) {
  if (behavior == null) return null;
  switch (behavior) {
    case material_ui.FloatingLabelBehavior.always:
      return flutter_material.FloatingLabelBehavior.always;
    case material_ui.FloatingLabelBehavior.auto:
      return flutter_material.FloatingLabelBehavior.auto;
    case material_ui.FloatingLabelBehavior.never:
      return flutter_material.FloatingLabelBehavior.never;
  }
}

flutter_material.VisualDensity? _convertVisualDensity(
  material_ui.VisualDensity? density,
) {
  if (density == null) return null;
  return flutter_material.VisualDensity(
    horizontal: density.horizontal,
    vertical: density.vertical,
  );
}
