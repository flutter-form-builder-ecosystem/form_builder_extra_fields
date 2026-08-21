import 'package:material_ui/material_ui.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import 'example_form.dart';

class ColorPickerExamples extends StatelessWidget {
  const ColorPickerExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        Text(
          'Tap a field to open that picker. The live values below show the Color stored on the form.',
        ),
        SizedBox(height: 16),
        FormBuilderColorPickerField(
          name: 'material_picker',
          initialValue: Colors.yellow,
          colorPickerType: ColorPickerType.materialPicker,
          decoration: InputDecoration(
            labelText: 'Material picker',
            helperText: 'Swatch grid from flutter_colorpicker',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderColorPickerField(
          name: 'color_picker',
          initialValue: Colors.blue,
          colorPickerType: ColorPickerType.colorPicker,
          decoration: InputDecoration(
            labelText: 'Color picker',
            helperText: 'Hue / saturation / value sliders',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderColorPickerField(
          name: 'block_picker',
          initialValue: Colors.green,
          colorPickerType: ColorPickerType.blockPicker,
          decoration: InputDecoration(
            labelText: 'Block picker',
            helperText: 'Fixed palette of blocks',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderColorPickerField(
          name: 'disabled_picker',
          initialValue: Colors.purple,
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Disabled',
            helperText: 'Shows the value but ignores taps',
          ),
        ),
      ],
    );
  }
}
