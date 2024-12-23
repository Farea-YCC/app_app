import 'package:flutter/material.dart';
import 'package:learning/models/course.dart';
import 'package:learning/providers/course_provider.dart';
import 'package:provider/provider.dart';

class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({super.key});

  @override
  State<AddCourseDialog> createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final TextEditingController courseController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  String? selectedInstitution;
  final List<String> institutions = [
    'Coursera',
    'Udemy',
    'edX',
    'LinkedIn Learning',
    'Pluralsight',
    'Khan Academy',
  ];

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Course'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Institution/Source',
                border: OutlineInputBorder(),
              ),
              value: selectedInstitution,
              items: institutions.map((source) {
                return DropdownMenuItem<String>(
                  value: source,
                  child: Text(source),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedInstitution = newValue;
                });
              },
            ),
            const SizedBox(height: 8.0),
            if (selectedInstitution == null)
              TextFormField(
                controller: institutionController,
                decoration: const InputDecoration(
                  labelText: 'Custom Institution',
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (courseController.text.isNotEmpty) {
              courseProvider.addCourse(
                Course(
                  name: courseController.text,
                  institution:
                      selectedInstitution ?? institutionController.text,
                ),
              );
              courseController.clear();
              institutionController.clear();
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    courseController.dispose();
    institutionController.dispose();
    super.dispose();
  }
}
