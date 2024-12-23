import 'package:flutter/material.dart';
import 'package:learning/providers/experience_provider.dart';
import 'package:learning/utils/custom_elevated_button.dart';
import 'package:learning/widgets/add_experience_dialog.dart';
import 'package:provider/provider.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  void _showAddExperienceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddExperienceDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ExperienceProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.experiences.length,
                    itemBuilder: (context, index) {
                      final exp = provider.experiences[index];
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(exp.title),
                          subtitle: Text('${exp.company} (${exp.dates})'),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              provider.removeExperience(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () => _showAddExperienceDialog(context),
                  text: 'Add Experience',
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
