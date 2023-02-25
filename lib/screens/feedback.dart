// ignore_for_file: unused_import, use_build_context_synchronously, sort_child_properties_last

import 'package:befit/constants/app_constants.dart';
import 'package:befit/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:befit/screens/firebase_options.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainHexColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 150,
                width: 599,
                decoration: BoxDecoration(
                  color: mainHexColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Give Feedback!",
                        style: TextStyle(fontSize: 32,  color: Colors.black ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Do You have a suggestion or found some bug?",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "Let us know in the form below",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100,),
            const Text('How was your experience? ', style: TextStyle(fontSize: 26, color: Colors.black),),
            const SizedBox(height: 25,),
            Center(
              child: ElevatedButton(
                  child: const Text("Send Feedback"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: accentHexColor),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const FeedbackDialog(),
                    );
                  }),
            ),
          ],
        ));
  }
}

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'Enter Your Feedback Here',
              filled: true,
            ),
            maxLines: 5,
            maxLength: 4096,
            textInputAction: TextInputAction.done,
            validator: (String? text) {
              if (text == null || text.isEmpty) {
                return 'Please Enter a Feedback';
              }
              return null;
            }),
      ),
      actions: [
        TextButton(
            onPressed: (() => Navigator.pop(context)),
            child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              String message;

              try {
                final collection =
                    FirebaseFirestore.instance.collection('BeFit');
                await collection.doc().set({
                  'timestamp': FieldValue.serverTimestamp(),
                  'feedback': _controller.text,
                });
                message = 'Feedback sent successfully';
              } catch (_) {
                message = 'Error when sending feedbak';
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              Navigator.pop(context);
            }
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}