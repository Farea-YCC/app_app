import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning/screens/courses_screen.dart';
import 'package:learning/screens/education_screen.dart';
import 'package:learning/screens/experience_screen.dart';
import 'package:learning/screens/languages_screen.dart';
import 'package:learning/screens/skills_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:printing/printing.dart' as print;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers for Personal Info
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
// Professional Information
  final List<Map<String, dynamic>> _experience = [];
  final List<Map<String, dynamic>> _education = [];

// Skills, Languages, and Courses
  final List<Map<String, String>> _skills = [];
  final List<Map<String, String>> _languages = [];
  final List<Map<String, String>> _courses = [];

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();
    pw.MemoryImage? profileImage;
    if (_selectedImage != null) {
      final bytes = await _selectedImage!.readAsBytes();
      profileImage = pw.MemoryImage(bytes);
    }

    // Load fonts
    final ttf = await rootBundle.load("assets/fonts/Amiri-Regular.ttf");
    final font = pw.Font.ttf(ttf);

    // Define custom colors
    final primaryColor = PdfColor.fromHex('#1E40AF'); // Deep blue
    final secondaryColor = PdfColor.fromHex('#6B7280'); // Gray
    final accentColor = PdfColor.fromHex('#3B82F6'); // Light blue

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // Header section with profile image and contact info
          pw.Container(
            padding: const pw.EdgeInsets.only(bottom: 20),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                  bottom: pw.BorderSide(color: secondaryColor, width: 0.5)),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (profileImage != null)
                  pw.Container(
                    width: 120,
                    height: 120,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      image: pw.DecorationImage(
                        image: profileImage,
                        fit: pw.BoxFit.cover,
                      ),
                      border: pw.Border.all(color: primaryColor, width: 2),
                    ),
                  ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        _nameController.text.toUpperCase(),
                        style: pw.TextStyle(
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      pw.Text(
                        _titleController.text,
                        style: pw.TextStyle(
                          fontSize: 18,
                          color: secondaryColor,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      _buildContactInfo(_phoneController.text, '📱'),
                      _buildContactInfo(_emailController.text, '✉️'),
                      _buildContactInfo(_addressController.text, '📍'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // Professional Summary
          _buildSection(
            'PROFESSIONAL SUMMARY',
            [
              pw.Paragraph(
                text: _summaryController.text,
                style: pw.TextStyle(
                  fontSize: 12,
                  lineSpacing: 1.5,
                  font: font,
                ),
              ),
            ],
            primaryColor,
          ),

          // Experience Section
          if (_experience.isNotEmpty)
            _buildSection(
              'PROFESSIONAL EXPERIENCE',
              _experience
                  .map((exp) => pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 15),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          '${exp['title']} | ${exp['company']}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: accentColor,
                          ),
                        ),
                        pw.Text(
                          exp['dates'],
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      exp['description'] ?? '',
                      style: const pw.TextStyle(
                        fontSize: 11,
                        lineSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
              primaryColor,
            ),

          // Education Section
          if (_education.isNotEmpty)
            _buildSection(
              'EDUCATION',
              _education
                  .map((edu) => pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${edu['degree']} in ${edu['major']}',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                        color: accentColor,
                      ),
                    ),
                    pw.Text(
                      '${edu['university']} - ${edu['graduationDate']}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
              primaryColor,
            ),

          // Skills Section
          if (_skills.isNotEmpty)
            _buildSection(
              'SKILLS',
              [
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _skills
                      .map((skill) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: pw.BoxDecoration(
                      color: accentColor,
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text(
                      '${skill['skill']} - ${skill['level']}',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ],
              primaryColor,
            ),

          // Languages Section
          if (_languages.isNotEmpty)
            _buildSection(
              'LANGUAGES',
              [
                pw.Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: _languages
                      .map((lang) => pw.Container(
                    child: pw.Column(
                      children: [
                        pw.Text(
                          '🗣️ ${lang['language']}',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          lang['level']!,
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ))
                      .toList(),
                ),
              ],
              primaryColor,
            ),

          // Courses Section
          if (_courses.isNotEmpty)
            _buildSection(
              'COURSES & CERTIFICATIONS',
              [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: _courses
                      .map((course) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 5),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('📚 ',
                            style: const pw.TextStyle(fontSize: 12)),
                        pw.Expanded(
                          child: pw.Text(
                            course['title']!,
                            style: const pw.TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ))
                      .toList(),
                ),
              ],
              primaryColor,
            ),
        ],
      ),
    );

    await print.Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _buildSection(
      String title, List<pw.Widget> children, PdfColor color) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.only(bottom: 5),
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(color: color, width: 1)),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  pw.Widget _buildContactInfo(String text, String icon) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(icon, style: const pw.TextStyle(fontSize: 12)),
          pw.SizedBox(width: 8),
          pw.Text(
            text,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('CV Builder', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Personal Info'),
            Tab(text: 'Experience'),
            Tab(text: 'Education'),
            Tab(text: 'Skills'),
            Tab(text: 'Languages'),
            Tab(text: 'Courses'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalInfoTab(),
          const ExperienceScreen(),
          const EducationScreen(),
          const SkillsScreen  (),
          const LanguagesScreen (),
          const CoursesScreen()
        ],
      ),
    );
  }

  Widget _buildPersonalInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : const AssetImage('assets/images/1.png') as ImageProvider,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField('Full Name', _nameController),
          _buildTextField('Professional Title', _titleController),
          _buildTextField('Address', _addressController),
          _buildTextField('Phone', _phoneController),
          _buildTextField('Email', _emailController),
          _buildTextField('Professional Summary', _summaryController,
              maxLines: 5),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _generatePdf,
            icon: const Icon(Icons.print),
            label: const Text('Generate PDF'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
