import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({super.key});

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void sendEmail(String body, String subject, List<String> recipients) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: recipients,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Error sending email: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                    hintText: 'Enter subject',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                    hintText: 'Enter body',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _key.currentState!.save();
                    sendEmail(bodyController.text, subjectController.text, [
                      emailController.text
                    ]); // Wrap emailController.text in a list
                    subjectController.clear();
                    bodyController.clear();
                    emailController.clear();
                  },
                  child: Text('Send'))
            ],
          ),
        ),
      ),
    );
  }
}
