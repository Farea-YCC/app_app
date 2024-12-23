import 'package:flutter/material.dart';
import 'package:learning/providers/language_provider.dart';
import 'package:learning/utils/custom_elevated_button.dart';
import 'package:learning/widgets/add_language_dialog.dart';
import 'package:provider/provider.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  void _showAddLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddLanguageDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<LanguageProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.languages.length,
                    itemBuilder: (context, index) {
                      final language = provider.languages[index];
                      return Card(
                        child: ListTile(
                          title: Text(language.language),
                          subtitle: Text('Level: ${language.proficiency}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.removeLanguage(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () => _showAddLanguageDialog(context),
                  text: 'Add Language',
                  icon: const Icon(Icons.add),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
