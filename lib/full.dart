// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';
// import 'package:printing/printing.dart' as print;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CourseProvider()),
//         ChangeNotifierProvider(create: (_) => EducationProvider()),
//       ],
//       child: const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: MyHomePage(
//           title: 'CV Createor',
//         ),
//       ),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// // Personal Information
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _summaryController = TextEditingController();
//   TextEditingController courseController = TextEditingController();
//   TextEditingController institutionController = TextEditingController();
//   TextEditingController skillController = TextEditingController();
//
// // Professional Information
//   final List<Map<String, dynamic>> _experience = [];
//   final List<Map<String, dynamic>> _education = [];
//
// // Skills, Languages, and Courses
//   final List<Map<String, String>> _skills = [];
//   final List<Map<String, String>> _languages = [];
//   final List<Map<String, String>> _courses = [];
//
// //SharedPreferences? _prefs;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 6, vsync: this);
// //_initializePrefs();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _generatePdf() async {
//     final pdf = pw.Document();
//     pw.MemoryImage? profileImage;
//     if (_selectedImage != null) {
//       final bytes = await _selectedImage!.readAsBytes();
//       profileImage = pw.MemoryImage(bytes);
//     }
//
// // Load fonts
//     final ttf = await rootBundle.load("assets/fonts/Amiri-Regular.ttf");
//     final font = pw.Font.ttf(ttf);
//
// // Define custom colors
//     final primaryColor = PdfColor.fromHex('#1E40AF'); // Deep blue
//     final secondaryColor = PdfColor.fromHex('#6B7280'); // Gray
//     final accentColor = PdfColor.fromHex('#3B82F6'); // Light blue
//
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.all(40),
//         build: (context) => [
// // Header section with profile image and contact info
//           pw.Container(
//             padding: const pw.EdgeInsets.only(bottom: 20),
//             decoration: pw.BoxDecoration(
//               border: pw.Border(
//                   bottom: pw.BorderSide(color: secondaryColor, width: 0.5)),
//             ),
//             child: pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 if (profileImage != null)
//                   pw.Container(
//                     width: 120,
//                     height: 120,
//                     decoration: pw.BoxDecoration(
//                       shape: pw.BoxShape.circle,
//                       image: pw.DecorationImage(
//                         image: profileImage,
//                         fit: pw.BoxFit.cover,
//                       ),
//                       border: pw.Border.all(color: primaryColor, width: 2),
//                     ),
//                   ),
//                 pw.SizedBox(width: 20),
//                 pw.Expanded(
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         _nameController.text.toUpperCase(),
//                         style: pw.TextStyle(
//                           fontSize: 28,
//                           fontWeight: pw.FontWeight.bold,
//                           color: primaryColor,
//                         ),
//                       ),
//                       pw.Text(
//                         _titleController.text,
//                         style: pw.TextStyle(
//                           fontSize: 18,
//                           color: secondaryColor,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                       pw.SizedBox(height: 10),
//                       _buildContactInfo(_phoneController.text, '📱'),
//                       _buildContactInfo(_emailController.text, '✉️'),
//                       _buildContactInfo(_addressController.text, '📍'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           pw.SizedBox(height: 20),
//
// // Professional Summary
//           _buildSection(
//             'PROFESSIONAL SUMMARY',
//             [
//               pw.Paragraph(
//                 text: _summaryController.text,
//                 style: pw.TextStyle(
//                   fontSize: 12,
//                   lineSpacing: 1.5,
//                   font: font,
//                 ),
//               ),
//             ],
//             primaryColor,
//           ),
//
// // Experience Section
//           if (_experience.isNotEmpty)
//             _buildSection(
//               'PROFESSIONAL EXPERIENCE',
//               _experience
//                   .map((exp) => pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 15),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Row(
//                       mainAxisAlignment:
//                       pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text(
//                           '${exp['title']} | ${exp['company']}',
//                           style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                             color: accentColor,
//                           ),
//                         ),
//                         pw.Text(
//                           exp['dates'],
//                           style: pw.TextStyle(
//                             fontSize: 12,
//                             color: secondaryColor,
//                             fontStyle: pw.FontStyle.italic,
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 5),
//                     pw.Text(
//                       exp['description'] ?? '',
//                       style: const pw.TextStyle(
//                         fontSize: 11,
//                         lineSpacing: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//                   .toList(),
//               primaryColor,
//             ),
//
// // Education Section
//           if (_education.isNotEmpty)
//             _buildSection(
//               'EDUCATION',
//               _education
//                   .map((edu) => pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 10),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       '${edu['degree']} in ${edu['major']}',
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                         color: accentColor,
//                       ),
//                     ),
//                     pw.Text(
//                       '${edu['university']} - ${edu['graduationDate']}',
//                       style: pw.TextStyle(
//                         fontSize: 12,
//                         color: secondaryColor,
//                         fontStyle: pw.FontStyle.italic,
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//                   .toList(),
//               primaryColor,
//             ),
//
// // Skills Section
//           if (_skills.isNotEmpty)
//             _buildSection(
//               'SKILLS',
//               [
//                 pw.Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: _skills
//                       .map((skill) => pw.Container(
//                     padding: const pw.EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 5,
//                     ),
//                     decoration: pw.BoxDecoration(
//                       color: accentColor,
//                       borderRadius: pw.BorderRadius.circular(5),
//                     ),
//                     child: pw.Text(
//                       '${skill['skill']} - ${skill['level']}',
//                       style: pw.TextStyle(
//                         color: PdfColors.white,
//                         fontSize: 10,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ))
//                       .toList(),
//                 ),
//               ],
//               primaryColor,
//             ),
//
// // Languages Section
//           if (_languages.isNotEmpty)
//             _buildSection(
//               'LANGUAGES',
//               [
//                 pw.Wrap(
//                   spacing: 20,
//                   runSpacing: 10,
//                   children: _languages
//                       .map((lang) => pw.Container(
//                     child: pw.Column(
//                       children: [
//                         pw.Text(
//                           '🗣️ ${lang['language']}',
//                           style: pw.TextStyle(
//                             fontSize: 12,
//                             fontWeight: pw.FontWeight.bold,
//                           ),
//                         ),
//                         pw.Text(
//                           lang['level']!,
//                           style: pw.TextStyle(
//                             fontSize: 10,
//                             color: secondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//                       .toList(),
//                 ),
//               ],
//               primaryColor,
//             ),
//
// // Courses Section
//           if (_courses.isNotEmpty)
//             _buildSection(
//               'COURSES & CERTIFICATIONS',
//               [
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: _courses
//                       .map((course) => pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 5),
//                     child: pw.Row(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text('📚 ',
//                             style: const pw.TextStyle(fontSize: 12)),
//                         pw.Expanded(
//                           child: pw.Text(
//                             course['title']!,
//                             style: const pw.TextStyle(fontSize: 11),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//                       .toList(),
//                 ),
//               ],
//               primaryColor,
//             ),
//         ],
//       ),
//     );
//
//     await print.Printing.layoutPdf(onLayout: (format) async => pdf.save());
//   }
//
//   pw.Widget _buildSection(
//       String title, List<pw.Widget> children, PdfColor color) {
//     return pw.Container(
//       margin: const pw.EdgeInsets.only(bottom: 20),
//       child: pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Container(
//             padding: const pw.EdgeInsets.only(bottom: 5),
//             decoration: pw.BoxDecoration(
//               border: pw.Border(bottom: pw.BorderSide(color: color, width: 1)),
//             ),
//             child: pw.Text(
//               title,
//               style: pw.TextStyle(
//                 color: color,
//                 fontSize: 16,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//           ),
//           pw.SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }
//
//   pw.Widget _buildContactInfo(String text, String icon) {
//     return pw.Container(
//       margin: const pw.EdgeInsets.only(bottom: 5),
//       child: pw.Row(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Text(icon, style: const pw.TextStyle(fontSize: 12)),
//           pw.SizedBox(width: 8),
//           pw.Text(
//             text,
//             style: const pw.TextStyle(fontSize: 11),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _addExperience() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController titleController = TextEditingController();
//         TextEditingController companyController = TextEditingController();
//         TextEditingController datesController = TextEditingController();
//         TextEditingController descriptionController = TextEditingController();
//
//         return AlertDialog(
//           title: const Text('Add Experience'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: titleController,
//                   decoration: const InputDecoration(labelText: 'Job Title'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: companyController,
//                   decoration: const InputDecoration(labelText: 'Company'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: datesController,
//                   decoration: const InputDecoration(
//                       labelText: 'Dates (e.g., 2020-2023)'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   maxLines: 3,
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _experience.add({
//                     'title': titleController.text,
//                     'company': companyController.text,
//                     'dates': datesController.text,
//                     'description': descriptionController.text,
//                   });
//                 });
//                 Navigator.pop(context);
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _addEducation() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController degreeController = TextEditingController();
//         TextEditingController majorController = TextEditingController();
//         TextEditingController universityController = TextEditingController();
//         TextEditingController graduationController = TextEditingController();
//
//         return AlertDialog(
//           title: const Text('Add Education'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: degreeController,
//                   decoration: const InputDecoration(labelText: 'Degree'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: majorController,
//                   decoration: const InputDecoration(labelText: 'Major'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: universityController,
//                   decoration: const InputDecoration(labelText: 'University'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: graduationController,
//                   decoration:
//                   const InputDecoration(labelText: 'Graduation Date'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _education.add({
//                     'degree': degreeController.text,
//                     'major': majorController.text,
//                     'university': universityController.text,
//                     'graduationDate': graduationController.text,
//                   });
//                 });
//                 Navigator.pop(context);
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _addSkill() {
//     String selectedLevel = 'Beginner';
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: const Text('Add Skill'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     controller: skillController,
//                     decoration: const InputDecoration(labelText: 'Skill'),
//                   ),
//                   DropdownButton<String>(
//                     value: selectedLevel,
//                     items: ['Beginner', 'Intermediate', 'Advanced', 'Expert']
//                         .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setStateDialog(() {
//                         selectedLevel = newValue!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     if (skillController.text.isNotEmpty) {
// // تحديث الحالة العامة
//                       setState(() {
//                         _skills.add({
//                           'skill': skillController.text,
//                           'level': selectedLevel,
//                         });
//                       });
//                       Navigator.pop(context); // إغلاق الحوار
//                     }
//                   },
//                   child: const Text('Add'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _addLanguages() {
//     showDialog(
//       context: context,
//       builder: (context) {
// // List of available languages
//         List<String> allLanguages = [
//           'Arabic',
//           'English',
//           'Italian',
//           'French',
//           'Spanish',
//           'German',
//           'Portuguese',
//           'Russian',
//           'Chinese',
//           'Japanese',
//           'Korean',
//           'Hindi',
//           'Bengali',
//           'Turkish',
//           'Dutch'
//         ];
//
// // Default selected language with levels
//         Map<String, String> selectedLanguages = {
//           'English': 'Fluent', // Default language with default level
//         };
//
// // List of levels
//         List<String> levels = [
//           'Mother tongue',
//           'Basic',
//           'Intermediate',
//           'Advanced',
//           'Fluent'
//         ];
//
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: const Text('Add Languages'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 10),
//                     DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: 'Select Language',
//                         border: OutlineInputBorder(),
//                       ),
//                       value: null, // Default: no language selected initially
//                       items: allLanguages.map((language) {
//                         return DropdownMenuItem<String>(
//                           value: language,
//                           child: Text(language),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setStateDialog(() {
//                           if (newValue != null &&
//                               !selectedLanguages.containsKey(newValue)) {
//                             selectedLanguages[newValue] =
//                             'Basic'; // Default level
//                           }
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     const Text('Selected Languages and Levels:'),
//                     Column(
//                       children: selectedLanguages.keys.map((lang) {
//                         return Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: Text(lang),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: DropdownButton<String>(
//                                 value: selectedLanguages[lang],
//                                 items: levels.map((level) {
//                                   return DropdownMenuItem<String>(
//                                     value: level,
//                                     child: Text(level),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newLevel) {
//                                   setStateDialog(() {
//                                     if (newLevel != null) {
//                                       selectedLanguages[lang] = newLevel;
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.remove_circle_outline),
//                               onPressed: () {
//                                 setStateDialog(() {
//                                   selectedLanguages.remove(lang);
//                                 });
//                               },
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       for (var lang in selectedLanguages.entries) {
// // Check if the language already exists
//                         bool alreadyExists = _languages
//                             .any((element) => element['language'] == lang.key);
//
//                         if (!alreadyExists) {
//                           _languages.add({
//                             'language': lang.key,
//                             'level': lang.value,
//                           });
//                         }
//                       }
//                     });
//
//                     Navigator.pop(context); // Close the dialog
//                   },
//                   child: const Text('Add'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _addCourse() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         List<String> institutions = [
//           'Coursera',
//           'Udemy',
//           'edX',
//           'LinkedIn Learning',
//           'Pluralsight',
//           'Khan Academy'
//         ];
//
//         String? selectedInstitution; // المتغير لتحديد المصدر المختار
//
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: const Text('Add Course'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller: courseController,
//                       decoration: const InputDecoration(
//                         labelText: 'Course Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 12.0),
//                     DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: 'Institution/Source',
//                         border: OutlineInputBorder(),
//                       ),
//                       value: selectedInstitution,
//                       items: institutions.map((source) {
//                         return DropdownMenuItem<String>(
//                           value: source,
//                           child: Text(source),
//                         );
//                       }).toList(),
//                       onChanged: (newValue) {
//                         setStateDialog(() {
//                           selectedInstitution = newValue;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 8.0),
//                     if (selectedInstitution == null)
//                       TextFormField(
//                         controller: institutionController,
//                         decoration: const InputDecoration(
//                           labelText: 'Custom Institution',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     if (courseController.text.isNotEmpty) {
//                       setState(() {
//                         _courses.add({
//                           'course': courseController.text,
//                           'institution':
//                           selectedInstitution ?? institutionController.text,
//                         });
//                       });
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: const Text('Add'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   _buildUploadImageSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         _selectedImage != null
//             ? CircleAvatar(
//           radius: 60,
//           backgroundImage: FileImage(_selectedImage!),
//         )
//             : const CircleAvatar(
//           radius: 60,
//           backgroundImage: AssetImage('assets/images/1.png'),
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton.icon(
//           onPressed: () => _pickImage(ImageSource.gallery),
//           icon: const Icon(Icons.photo_library),
//           label: const Text('Upload Photo'),
//         ),
//       ],
//     );
//   }
//
//   File? _selectedImage;
//
//   Future<void> _pickImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: source);
//
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     }
//   }
//
//   Widget _buildTextField(
//       String label,
//       TextEditingController controller, {
//         int maxLines = 1,
//         String? Function(String?)? validator,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         validator: validator, // استخدام التحقق هنا
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
//
//   Widget buildForm(BuildContext context) {
//     return Form(
//       key: _formKey, // مفتاح النموذج
//       child: Column(
//         children: [
//           _buildTextField(
//             'الاسم',
//             _nameController,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'من فضلك ادخل الاسم';
//               }
//               if (value.length > 30) {
//                 return 'الاسم لا يجب أن يزيد عن 30 حرفًا';
//               }
//               return null;
//             },
//           ),
//           _buildTextField(
//             'رقم الهاتف',
//             _phoneController,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'من فضلك ادخل رقم الهاتف';
//               }
//               if (!RegExp(r'^(71|70|73|78|77)\d{7}$').hasMatch(value)) {
//                 return 'رقم الهاتف غير صحيح، يجب أن يبدأ بـ 71 أو 70 أو 73 أو 78 أو 77 ويتكون من 9 أرقام';
//               }
//               return null;
//             },
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('تم التحقق بنجاح!')),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                       content: Text('الرجاء ملء جميع الحقول بشكل صحيح')),
//                 );
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget customElevatedButton({
//     required void Function() onPressed,
//     required String label,
//     required Icon icon,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50, // ارتفاع الزر
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         icon: icon,
//         label: Text(label,style: const TextStyle(color: Colors.black),),
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white,
//           backgroundColor: AppColors.kscaffoldBackgroundColor,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 5,
//         ),
//
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Colors.white,
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           tabs: const [
//             Tab(text: 'Personal Info'),
//             Tab(text: 'Experience'),
//             Tab(text: 'Education'),
//             Tab(text: 'Skills'),
//             Tab(text: 'Languages'),
//             Tab(text: 'Courses'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
// // Personal Info Tab
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 _buildUploadImageSection(),
//                 _buildTextField('Full Name', _nameController),
//                 _buildTextField('Professional Title', _titleController),
//                 _buildTextField('Address', _addressController),
//                 _buildTextField('Phone', _phoneController),
//                 _buildTextField('Email', _emailController),
//                 _buildTextField('Professional Summary', _summaryController,
//                     maxLines: 5),
//                 Center(
//                   child: Container(
//                     padding: const EdgeInsets.all(30.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.center, // محاذاة الأزرار في المنتصف
//                       children: [
//                         ElevatedButton.icon(
//                           icon: const Icon(Icons.save,
//                               color: Colors.white), // أيقونة الزر
//                           label: const Text(
//                             "Save",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green, // لون الخلفية
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24.0), // حجم الزر
//                             minimumSize:
//                             const Size(100, 50), // التحكم في ارتفاع وعرض الزر
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   10.0), // استدارة حواف الزر
//                             ),
//                             elevation: 0, // إزالة الظل
//                           ),
//                           onPressed: /* _saveDataToPrefs*/ () {},
//                         ),
//                         const SizedBox(width: 24.0), // تباعد بين الأزرار
// // زر الطباعة مع الأيقونة والنص
//                         ElevatedButton.icon(
//                           icon: const Icon(Icons.print, color: Colors.white),
//                           label: const Text(
//                             "Print",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue, // لون الخلفية
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24.0), // حجم الزر
//                             minimumSize:
//                             const Size(100, 50), // التحكم في ارتفاع وعرض الزر
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             elevation: 0, // إضافة ظل
//                           ),
//                           onPressed: _generatePdf,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: _experience.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == _experience.length) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: customElevatedButton(
//                           onPressed: _addExperience,
//                           label: 'Add Experience',
//                           icon: const Icon(Icons.add,color: Colors.black,),
//
//                         ),
//                       );
//                     }
//                     final exp = _experience[index];
//                     return Card(
//                       color: Colors.white,
//                       child: ListTile(
//                         title: Text(exp['title']),
//                         subtitle: Text('${exp['company']} (${exp['dates']})'),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete,color: Colors.red,),
//                           onPressed: () {
//                             setState(() {
//                               _experience.removeAt(index);
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
// // Education Tab
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: _education.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == _education.length) {
//                       return customElevatedButton(
//                         onPressed: _addEducation,
//                         label: 'Add Education',
//                         icon: const Icon(Icons.add),
//                       );
//                     }
//                     final edu = _education[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text('${edu['degree']} in ${edu['major']}'),
//                         subtitle: Text(
//                             '${edu['university']} (${edu['graduationDate']})'),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             setState(() {
//                               _education.removeAt(index);
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
// // Skills Tab
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: _skills.length + 1, // نضيف 1 للزر
//                   itemBuilder: (context, index) {
// // التحقق إذا كان هذا هو آخر عنصر (زر الإضافة)
//                     if (index == _skills.length) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: customElevatedButton(
//                           onPressed: _addSkill, // استدعاء دالة الإضافة
//                           label: 'Add Skill',
//                           icon: const Icon(Icons.add),
//                         ),
//                       );
//                     }
//
//                     final skill = _skills[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(skill['skill']!),
//                         subtitle: Text(skill['level']!),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             setState(() {
//                               _skills.removeAt(index); // حذف المهارة
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
// // Languages Tab
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: _languages.length + 1, // نضيف 1 للزر في النهاية
//                   itemBuilder: (context, index) {
//                     if (index == _languages.length) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: customElevatedButton(
//                           onPressed: _addLanguages, // استدعاء دالة الإضافة
//                           label: 'Add Languages',
//                           icon: const Icon(Icons.add),
//                         ),
//                       );
//                     }
//                     final lang = _languages[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(lang['language']!),
//                         subtitle: Text('Level: ${lang['level']!}'),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             setState(() {
//                               _languages
//                                   .removeAt(index); // حذف اللغة من القائمة
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
// // Courses Tab
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: _courses.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == _courses.length) {
// // زر الإضافة يظهر بعد العناصر
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: customElevatedButton(
//                           onPressed: _addCourse, // دالة الإضافة
//                           label: 'Add Course',
//                           icon: const Icon(Icons.add),
//                         ),
//                       );
//                     }
//                     final course = _courses[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(
//                           course['course']!,
//                         ),
//                         subtitle: Text(
//                           'Institution: ${course['institution']}',
//                         ),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             setState(() {
//                               _courses.removeAt(index);
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class AppColors {
//   static const Color kContentColor = Color(0xfffdfdfd);
//   static const Color kscaffoldBackgroundColor = Color(0xfff1f0f5);
//   static const Color kprimaryColor = Color(0xffe81515);
//   static const Color kTextAndIconColor = Color(0xFF1C3941);
//   static const Color kunselectedItemColor = Color(0xFF8E8D90);
// }
// class CustomElevatedButton extends StatelessWidget {
//   final String text; // نص الزر
//   final VoidCallback onPressed; // وظيفة الزر عند الضغط
//   final Color color; // اللون الخلفي للزر
//   final Color textColor; // لون النص داخل الزر
//   final double elevation; // مستوى الظل (Elevation) للزر
//   final EdgeInsetsGeometry padding; // المسافة الداخلية للزر
//
//   const CustomElevatedButton({super.key,
//     required this.text,
//     required this.onPressed,
//     this.color = Colors.blue,
//     this.textColor = Colors.white,
//     this.elevation = 2.0,
//     this.padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), required String label,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         foregroundColor: textColor, backgroundColor: color,
//         elevation: elevation,
//         padding: padding,
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
// class AppConstants {
// // الألوان
//   static const Color primaryColor = Color(0xFF1D3557); // اللون الأساسي
//   static const Color secondaryColor = Color(0xFF457B9D); // اللون الثانوي
//   static const Color backgroundColor = Color(0xFFF1FAEE); // اللون الخلفي
// }
// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     primaryColor: AppConstants.primaryColor,
//     scaffoldBackgroundColor: AppConstants.backgroundColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppConstants.primaryColor,
//       titleTextStyle: TextStyle(
//         color: Colors.white,
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     colorScheme: const ColorScheme.light(
//       primary: AppConstants.primaryColor,
//       secondary: AppConstants.secondaryColor,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(
//         color: Colors.black,
//         fontSize: 16.0,
//         fontWeight: FontWeight.normal,
//       ),
//       bodyMedium: TextStyle(
//         color: Colors.black54,
//         fontSize: 14.0,
//       ),
//       displayLarge: TextStyle(
//         color: AppConstants.primaryColor,
//         fontSize: 24.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
//
//   static ThemeData darkTheme = ThemeData(
//     primaryColor: AppConstants.primaryColor,
//     scaffoldBackgroundColor: Colors.black,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.black,
//       titleTextStyle: TextStyle(
//         color: Colors.white,
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     colorScheme: const ColorScheme.dark(
//       primary: AppConstants.primaryColor,
//       secondary: AppConstants.secondaryColor,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(
//         color: Colors.white,
//         fontSize: 16.0,
//         fontWeight: FontWeight.normal,
//       ),
//       bodyMedium: TextStyle(
//         color: Colors.white70,
//         fontSize: 14.0,
//       ),
//       displayLarge: TextStyle(
//         color: AppConstants.primaryColor,
//         fontSize: 24.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }
// class TextInputField extends StatelessWidget {
//   final String label; // التسمية أو العنوان للحقل
//   final TextEditingController controller; // المتحكم بالنص في الحقل
//   final TextInputType keyboardType; // نوع لوحة المفاتيح (مثل نص أو رقم)
//   final String? Function(String?)? validator; // دالة التحقق (validator)
//   final bool obscureText; // هل الحقل يحتوي على نصوص مخفية (مثل كلمة المرور)
//
//   const TextInputField({super.key,
//     required this.label,
//     required this.controller,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.obscureText = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         validator: validator,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
//         ),
//       ),
//     );
//   }
// }
// class CourseProvider with ChangeNotifier {
//   final List<Course> _courses = [];
//
//   List<Course> get courses => _courses;
//   void addCourse(Course course) {
//     _courses.add(course);
//     notifyListeners();
//   }
//   void removeCourse(int index) {
//     _courses.removeAt(index);
//     notifyListeners();
//   }
//   void updateCourse(int index, Course course) {
//     _courses[index] = course;
//     notifyListeners();
//   }
// }
// class Course {
//   final String name;
//   final String institution;
//
//   Course({required this.name, required this.institution});
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'institution': institution,
//   };
//
//   factory Course.fromJson(Map<String, dynamic> json) {
//     return Course(
//       name: json['name'],
//       institution: json['institution'],
//     );
//   }
// }class Education {final String degree;final String institution;final String year;
//   Education({required this.degree, required this.institution, required this.year,});Map<String, dynamic> toMap() {
//     return {
//       'degree': degree,
//       'institution': institution,
//       'year': year,
//     };
//   }
//   factory Education.fromMap(Map<String, dynamic> map) {
//     return Education(
//       degree: map['degree'],
//       institution: map['institution'],
//       year: map['year'],
//     );
//   }
// }
// class Experience {
//   final String title;
//   final String company;
//   final String duration;
//
//   Experience({
//     required this.title,
//     required this.company,
//     required this.duration,
//   });
//
// // تحويل الكائن إلى Map
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'company': company,
//       'duration': duration,
//     };
//   }
//
// // تحويل Map إلى كائن
//   factory Experience.fromMap(Map<String, dynamic> map) {
//     return Experience(
//       title: map['title'],
//       company: map['company'],
//       duration: map['duration'],
//     );
//   }
// }
// class Language {
//   final String language;
//   final String proficiency;
//
//   Language({
//     required this.language,
//     required this.proficiency,
//   });
//
// // تحويل الكائن إلى Map
//   Map<String, dynamic> toMap() {
//     return {
//       'language': language,
//       'proficiency': proficiency,
//     };
//   }
//
// // تحويل Map إلى كائن
//   factory Language.fromMap(Map<String, dynamic> map) {
//     return Language(
//       language: map['language'],
//       proficiency: map['proficiency'],
//     );
//   }
// }
// class PersonalInfo {
//   final String name;
//   final String email;
//   final String phone;
//
//   PersonalInfo({
//     required this.name,
//     required this.email,
//     required this.phone,
//   });
//
// // تحويل الكائن إلى Map
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'phone': phone,
//     };
//   }
//
// // تحويل Map إلى كائن
//   factory PersonalInfo.fromMap(Map<String, dynamic> map) {
//     return PersonalInfo(
//       name: map['name'],
//       email: map['email'],
//       phone: map['phone'],
//     );
//   }
// }
// class EducationProvider with ChangeNotifier {
//   final List<Education> _educations = [];
//
//   List<Education> get educations => _educations;
//
// // إضافة تعليم جديد
//   void addEducation(Education education) {
//     _educations.add(education);
//     notifyListeners();
//   }
//
// // حذف تعليم
//   void removeEducation(int index) {
//     _educations.removeAt(index);
//     notifyListeners();
//   }
//
// // تحديث تعليم
//   void updateEducation(int index, Education education) {
//     _educations[index] = education;
//     notifyListeners();
//   }
// }
// class ExperienceProvider with ChangeNotifier {
//   final List<Experience> _experiences = [];
//
//   List<Experience> get experiences => _experiences;
//
//   void addExperience(Experience experience) {
//     _experiences.add(experience);
//     notifyListeners();
//   }
//   void removeExperience(int index) {
//     _experiences.removeAt(index);
//     notifyListeners();
//   }
//   void updateExperience(int index, Experience experience) {
//     _experiences[index] = experience;
//     notifyListeners();
//   }
// }