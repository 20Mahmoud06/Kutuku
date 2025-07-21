import 'dart:io';
import 'package:final_project/core/routes/route_names.dart';
import 'package:final_project/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _displayName = "User Name";
  String _displayEmail = "";
  File? _image;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().stream.listen((state) {
      if (state is Authenticated) {
        _loadProfileData();
      }
    });
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    if (mounted) {
      setState(() {
        _displayName =
            prefs.getString('userName') ?? user?.displayName ?? 'User Name';
        _displayEmail = user?.email ?? '';
        final imagePath = prefs.getString('userImagePath');
        if (imagePath != null) {
          _image = File(imagePath);
        } else {
          _image = null;
        }
      });
    }
  }

  ImageProvider<Object>? _getImageProvider() {
    final user = FirebaseAuth.instance.currentUser;
    if (_image != null) {
      return FileImage(_image!);
    }
    if (user?.photoURL != null && user!.photoURL!.isNotEmpty) {
      return NetworkImage(user.photoURL!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _getImageProvider();
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          rightIcon: IconButton(
            icon: Icon(Icons.edit_outlined, color: theme.iconTheme.color),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.editProfilePage)
                  .then((_) {
                _loadProfileData();
              });
            },
          ),
          leftIcon: Icons.arrow_back_ios_new,
          titleText: 'Profile',
          onLeftIconPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: theme.colorScheme.secondary.withOpacity(0.3),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: imageProvider,
                      child: (imageProvider == null)
                          ? Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey.shade400,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                      text: _displayName,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  CustomText(
                      text: _displayEmail,
                      fontSize: 16,
                      color: theme.textTheme.bodyMedium?.color),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          text: 'Full Name',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hintText: _displayName, enabled: false, readOnly: true),
                      const SizedBox(height: 20),
                      const CustomText(
                          text: 'Email Address',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hintText: _displayEmail, enabled: false, readOnly: true),
                      const SizedBox(height: 20),
                      const CustomText(
                          text: 'Password',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 10),
                      const CustomTextField(
                        hintText: '••••••••',
                        enabled: false,
                        readOnly: true,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
