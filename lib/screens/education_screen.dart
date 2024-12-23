import 'package:flutter/material.dart';
import 'package:learning/providers/education_provider.dart';
import 'package:learning/utils/custom_elevated_button.dart';
import 'package:learning/widgets/add_edcation_dialog.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  void _showAddEducationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddEducationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<EducationProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.educations.length,
                    itemBuilder: (context, index) {
                      final edu = provider.educations[index];
                      return Card(
                        child: ListTile(
                          title: Text('${edu.degree} in ${edu.major}'),
                          subtitle:
                              Text('${edu.university} (${edu.graduationDate})'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.removeEducation(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () => _showAddEducationDialog(context),
                  text: 'Add Education',
                  icon: const Icon(Icons.add, color: Colors.black),
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
