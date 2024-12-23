import 'package:flutter/material.dart';
import 'package:learning/models/experience.dart';
import 'package:learning/providers/experience_provider.dart';
import 'package:provider/provider.dart';

class AddExperienceDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController datesController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddExperienceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExperienceProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Experience'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Job Title'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(labelText: 'Company'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: datesController,
              decoration:
                  const InputDecoration(labelText: 'Dates (e.g., 2020-2023)'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
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
            if (titleController.text.isNotEmpty &&
                companyController.text.isNotEmpty &&
                datesController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty) {
              provider.addExperience(Experience(
                title: titleController.text,
                company: companyController.text,
                dates: datesController.text,
                description: descriptionController.text,
              ));
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
