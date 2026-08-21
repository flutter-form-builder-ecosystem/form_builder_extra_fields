import 'package:material_ui/material_ui.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Shared form chrome so each field page can show live values.
class ExampleForm extends StatefulWidget {
  final List<Widget> children;

  const ExampleForm({super.key, required this.children});

  @override
  State<ExampleForm> createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _valueText = '{}';

  void _refreshValue() {
    _formKey.currentState?.save();
    setState(() {
      _valueText = _stringify(_formKey.currentState?.value);
    });
  }

  String _stringify(Map<String, dynamic>? value) {
    if (value == null || value.isEmpty) {
      return '{}';
    }
    return value.entries
        .map((entry) => '${entry.key}: ${_describe(entry.value)}')
        .join('\n');
  }

  String _describe(dynamic value) {
    if (value == null) {
      return 'null';
    }
    if (value is Color) {
      return '#${value.toARGB32().toRadixString(16).padLeft(8, '0')}';
    }
    if (value is List<int>) {
      return '${value.length} bytes';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: _refreshValue,
      child: ListView(
        children: [
          ...widget.children,
          const SizedBox(height: 16),
          Text('Current values', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SelectableText(_valueText),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.saveAndValidate();
                    _refreshValue();
                  },
                  child: const Text('Submit'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _refreshValue();
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
