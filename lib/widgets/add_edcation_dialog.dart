import 'package:flutter/material.dart';
import 'package:learning/models/education.dart';
import 'package:learning/providers/education_provider.dart';
import 'package:provider/provider.dart';

class AddEducationDialog extends StatelessWidget {
  AddEducationDialog({super.key});
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController graduationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducationProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Education'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: degreeController,
              decoration: const InputDecoration(labelText: 'Degree'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: majorController,
              decoration: const InputDecoration(labelText: 'Major'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: universityController,
              decoration: const InputDecoration(labelText: 'University'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: graduationController,
              decoration: const InputDecoration(labelText: 'Graduation Date'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (degreeController.text.isNotEmpty &&
                majorController.text.isNotEmpty &&
                universityController.text.isNotEmpty &&
                graduationController.text.isNotEmpty) {
              provider.addEducation(
                Education(
                  degree: degreeController.text,
                  major: majorController.text,
                  university: universityController.text,
                  graduationDate: graduationController.text,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
