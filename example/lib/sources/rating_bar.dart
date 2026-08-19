import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import 'example_form.dart';

class RatingBarExamples extends StatelessWidget {
  const RatingBarExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleForm(
      children: [
        Text(
          'The form stores a double. Half-star mode lets you pick 0.5 steps.',
        ),
        SizedBox(height: 16),
        FormBuilderRatingBar(
          name: 'stars',
          initialValue: 3,
          itemSize: 32,
          decoration: InputDecoration(
            labelText: 'Whole stars',
            helperText: 'Tap or drag across five stars',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderRatingBar(
          name: 'half_stars',
          initialValue: 2.5,
          allowHalfRating: true,
          itemSize: 32,
          decoration: InputDecoration(
            labelText: 'Half stars',
            helperText: 'Tap the left or right half of a star',
          ),
        ),
        SizedBox(height: 16),
        FormBuilderRatingBar(
          name: 'disabled',
          initialValue: 4,
          enabled: false,
          itemSize: 32,
          decoration: InputDecoration(
            labelText: 'Disabled',
            helperText: 'Ignores taps',
          ),
        ),
      ],
    );
  }
}
