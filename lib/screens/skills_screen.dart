import 'package:flutter/material.dart';
import 'package:learning/models/skill.dart';
import 'package:learning/providers/skill_provider.dart';
import 'package:learning/utils/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  void _addSkill(BuildContext context) {
    final TextEditingController skillController = TextEditingController();
    String selectedLevel = 'Beginner';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Skill'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: skillController,
                  decoration: const InputDecoration(
                    labelText: 'Skill',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Skill Level',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedLevel,
                  items: ['Beginner', 'Intermediate', 'Advanced', 'Expert']
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedLevel = value!;
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
                if (skillController.text.isNotEmpty) {
                  final skill = Skill(
                    skill: skillController.text,
                    level: selectedLevel,
                  );
                  Provider.of<SkillProvider>(context, listen: false)
                      .addSkill(skill);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SkillProvider>(
          builder: (context, skillProvider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: skillProvider.skills.length,
                    itemBuilder: (context, index) {
                      final skill = skillProvider.skills[index];
                      return Card(
                        child: ListTile(
                          title: Text(skill.skill),
                          subtitle: Text(skill.level),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              skillProvider.removeSkill(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomElevatedButton(
                    onPressed: () => _addSkill(context),
                    text: '',
                    label: 'Add Skill',
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
