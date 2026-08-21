import 'package:material_ui/material_ui.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import 'example_form.dart';

class SignaturePadExamples extends StatelessWidget {
  const SignaturePadExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        const Text(
          'Draw on the pad. The form value is the PNG bytes. Clear wipes the drawing and the field.',
        ),
        const SizedBox(height: 16),
        FormBuilderSignaturePad(
          name: 'signature',
          height: 180,
          border: Border.all(color: Colors.green),
          decoration: const InputDecoration(
            labelText: 'Signature',
            helperText: 'Draw, then watch the byte length below',
          ),
        ),
      ],
    );
  }
}
