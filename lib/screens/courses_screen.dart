import 'package:flutter/material.dart';
import 'package:learning/providers/course_provider.dart';
import 'package:learning/widgets/add_course_dialog.dart';
import 'package:provider/provider.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});
  void _showAddCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddCourseDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, courseProvider, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: courseProvider.courses.length,
                    itemBuilder: (context, index) {
                      final course = courseProvider.courses[index];
                      return Card(
                        child: ListTile(
                          title: Text(course.name),
                          subtitle: Text('Institution: ${course.institution}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              courseProvider.removeCourse(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddCourseDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Course'),
            ),
          ],
        ),
      ),
    );
  }
}
