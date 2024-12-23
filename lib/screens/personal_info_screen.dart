import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning/providers/PersonalInfoProvider.dart';
import 'package:learning/utils/text_input_field.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonalInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            provider.profileImage != null
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(provider.profileImage!),
                  )
                : const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/1.png'),
                  ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  provider.setProfileImage(File(image.path));
                }
              },
              icon: const Icon(Icons.photo_library),
              label: const Text('Upload Photo'),
            ),
            const SizedBox(height: 20),
            TextInputField(
              label: 'Full Name',
              controller: TextEditingController(text: provider.fullName),
              onChanged: provider.setFullName,
            ),
            TextInputField(
              label: 'Professional Title',
              controller:
                  TextEditingController(text: provider.professionalTitle),
              onChanged: provider.setProfessionalTitle,
            ),
            TextInputField(
              label: 'Address',
              controller: TextEditingController(text: provider.address),
              onChanged: provider.setAddress,
            ),
            TextInputField(
              label: 'Phone',
              controller: TextEditingController(text: provider.phone),
              keyboardType: TextInputType.phone,
              onChanged: provider.setPhone,
            ),
            TextInputField(
              label: 'Email',
              controller: TextEditingController(text: provider.email),
              keyboardType: TextInputType.emailAddress,
              onChanged: provider.setEmail,
            ),
            TextInputField(
              label: 'Professional Summary',
              controller: TextEditingController(text: provider.summary),
              maxLines: 5,
              onChanged: provider.setSummary,
            ),
          ],
        ),
      ),
    );
  }
}
