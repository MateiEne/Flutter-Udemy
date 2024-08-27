import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance; // gives access to an firebase object that will be created and managed behind
// the scenes by the firebase SDK. This is setup once outside of the classes because I can the use that same firebase object
// in my entire code

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<
      FormState>(); // through this form key I get access to the form data (this form key is assigned to the Form widget
  bool _isInLoginMode = true;

  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUsername = '';

  File? _selectedImage;
  bool _isAuthenticating = false;

  void _submit() async {
    final isValid = _formKey.currentState!
        .validate(); // I know that this method will be called only when the button is pressed, so the current state of the _formKey wont be null

    if (!isValid || !_isInLoginMode && _selectedImage == null) {
      return;
    }

    _formKey.currentState!.save(); // triggers the onSave function on the Form widget

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isInLoginMode) {
        final UserCredential userCredentials =
            await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
      } else {
        final UserCredential userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword); // uses firebase SDK, witch is easier then HTTP request

        final Reference storageRef = FirebaseStorage.instance //
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final String imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance //
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }

      if (!ScaffoldMessenger.of(context).mounted) {
        return;
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isInLoginMode)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              // can return an error message (a string) if you consider the value to be invalid, otherwise you can return null
                              if (value == null || value.trim().isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          if (!_isInLoginMode)
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Username'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty || value.trim().length < 4) {
                                  return 'Please enter at least 4 characters.';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              // can return an error message (a string) if you consider the value to be invalid, otherwise you can return null
                              if (value == null || value.trim().isEmpty || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating) const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              child: Text(_isInLoginMode ? 'Login' : 'Signup'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isInLoginMode = !_isInLoginMode;
                                });
                              },
                              child: Text(_isInLoginMode ? 'Create an account' : 'I already have an account'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
