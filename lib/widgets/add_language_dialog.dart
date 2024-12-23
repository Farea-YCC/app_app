import 'package:flutter/material.dart';
import 'package:learning/models/language.dart';
import 'package:learning/providers/language_provider.dart';
import 'package:provider/provider.dart';

class AddLanguageDialog extends StatefulWidget {
  const AddLanguageDialog({super.key});

  @override
  State<AddLanguageDialog> createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends State<AddLanguageDialog> {
  String? selectedLanguage;
  String selectedProficiency = 'Basic';

  final List<String> allLanguages = [
    'Arabic',
    'English',
    'Italian',
    'French',
    'Spanish',
    'German',
    'Portuguese',
    'Russian',
    'Chinese',
    'Japanese',
    'Korean',
    'Hindi',
    'Bengali',
    'Turkish',
    'Dutch',
  ];

  final List<String> proficiencyLevels = [
    'Mother tongue',
    'Basic',
    'Intermediate',
    'Advanced',
    'Fluent',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Language'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Language',
                border: OutlineInputBorder(),
              ),
              items: allLanguages.map((language) {
                return DropdownMenuItem(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Proficiency Level',
                border: OutlineInputBorder(),
              ),
              value: selectedProficiency,
              items: proficiencyLevels.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedProficiency = value!;
                });
              },
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
            if (selectedLanguage != null) {
              Provider.of<LanguageProvider>(context, listen: false).addLanguage(
                Language(
                  language: selectedLanguage!,
                  proficiency: selectedProficiency,
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
