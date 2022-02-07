import 'package:ncertclass1to12th/launcher_config/launcher.dart';
import 'package:flutter/material.dart';

class CorrectionForm extends StatefulWidget {
  @override
  _CorrectionFormState createState() => _CorrectionFormState();
}

class _CorrectionFormState extends State<CorrectionForm> {
  late String bookName;
  late String chapterName;
  late String email;
  late String pageNo;
  late String subjectName;
  late String topicName;
  late String others;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildBookName() => TextFormField(
        decoration: InputDecoration(
          hintText: 'Ex-NCERT,Exampler',
          labelText: 'Book-Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 15,
        onSaved: (value) => setState(() => bookName = value!),
      );

  Widget buildSubjectName() => TextFormField(
        decoration: InputDecoration(
          hintText: 'Ex-Math,Science',
          labelText: 'Subject-Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 25,
        onSaved: (value) => setState(() => subjectName = value!),
      );

  Widget buildChapterName() => TextFormField(
        decoration: InputDecoration(
          hintText: 'Ex-Triangle',
          labelText: 'Chapter-Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 25,
        onSaved: (value) => setState(() => chapterName = value!),
      );

  Widget buildPageNo() => TextFormField(
        decoration: InputDecoration(
          hintText: 'Ex-9',
          labelText: 'Page-no',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (!RegExp(r'[0-9]').hasMatch(value!)) {
            return 'Enter Numerical number';
          } else {
            return null;
          }
        },
        maxLength: 3,
        onSaved: (value) => setState(() => pageNo = value!),
      );

  Widget buildEmail() => TextFormField(
        decoration: InputDecoration(
          hintText: 'youremail@gmail.com',
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => email = value!),
      );

  Widget buildOthers() => TextFormField(
        decoration: InputDecoration(
          hintText: 'Ex-Faceing Problem while using App',
          labelText: 'others',
          border: OutlineInputBorder(),
        ),
        maxLength: 150,
        onSaved: (value) => setState(() => others = value!),
      );

  Widget buildSubmit() => Builder(
      builder: (context) => GestureDetector(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xFF2f5fe8),
                    const Color(0xFF5b59ec),
                    const Color(0xFF7d50ed),
                    const Color(0xFF9c43ec),
                    const Color(0xFFb82fe8),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                'Send',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                _formKey.currentState!.save();

                Utils.openEmail(
                  toEmail: email,
                  subject: 'Correction in Books and Solutions',
                  body: '''
Book_Name:$bookName
Subject_Name:$subjectName
Chapter_Name:$chapterName
Page no:$pageNo
others:$others
''',
                );
              }
            },
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildBookName(),
            const SizedBox(height: 16),
            buildSubjectName(),
            const SizedBox(height: 16),
            buildChapterName(),
            const SizedBox(height: 16),
            buildPageNo(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildOthers(),
            const SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      ),
    );
  }
}
