import 'package:material_ui/material_ui.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import 'example_form.dart';

class TouchSpinExamples extends StatelessWidget {
  const TouchSpinExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        Text(
          'Plus and minus change the number. min / max stop the buttons when you hit the edge.',
        ),
        SizedBox(height: 16),
        FormBuilderTouchSpin(
          name: 'quantity',
          initialValue: 10,
          step: 1,
          min: 0,
          max: 20,
          iconSize: 36,
          decoration: InputDecoration(
            labelText: 'Quantity',
            helperText: 'Step 1, from 0 to 20',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderTouchSpin(
          name: 'score',
          initialValue: 0,
          step: 5,
          min: 0,
          max: 100,
          decoration: InputDecoration(
            labelText: 'Score',
            helperText: 'Step 5, from 0 to 100',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderTouchSpin(
          name: 'disabled',
          initialValue: 3,
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Disabled',
            helperText: 'Buttons do nothing',
          ),
        ),
      ],
    );
  }
}
