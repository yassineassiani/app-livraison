
// ignore_for_file: unused_field, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homc extends StatefulWidget {
  const Homc({Key? key}) : super(key: key);

  @override
  State<Homc> createState() => _HomcState();
}

class _HomcState extends State<Homc> {
  File? _imageFile;
  String? _imageUrl;
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _retrieveProfileImageUrl();
  }

  Future<void> _retrieveProfileImageUrl() async {
    if (_user != null) {
      // Retrieve the profile image URL for the logged-in user from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      setState(() {
        _imageUrl = userSnapshot['profileImageUrl'];
      });
    }
  }

  Future<void> _selectAndUploadImage() async {
    File? imageFile = await pickImage();
    if (imageFile != null && _user != null) {
      String userId = _user!.uid;
      String? imageUrl = await uploadImageToStorage(imageFile, userId);
      if (imageUrl != null) {
        setState(() {
          _imageFile = imageFile;
          _imageUrl = imageUrl;
        });
        updateProfileImageUrl(userId, imageUrl);
      }
    }
  }

  Future<File?> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadImageToStorage(File imageFile, String userId) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('profile_images/$userId.png');

    final uploadTask = ref.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == TaskState.success) {
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    }

    return null;
  }

  Future<void> updateProfileImageUrl(String userId, String imageUrl) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users').doc(userId);
    await userDoc.set({'profileImageUrl': imageUrl}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageUrl != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_imageUrl!),
                  )
                : Text('No profile image'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectAndUploadImage,
              child: Text('Select and Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}