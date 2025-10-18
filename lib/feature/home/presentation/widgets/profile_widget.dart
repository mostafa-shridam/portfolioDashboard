import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/core/theme/style.dart';

import '../../../../core/local_service/save_user.dart';
import '../../../../core/mixins/image_picker.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/my_text_filed.dart';
import '../../../auth/data/providers/auth.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  const ProfileWidget({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ConsumerStatefulWidget>
    with ImagePickerMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  Uint8List? _selectedImageBytes;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userData = ref.watch(saveUserProvider).getUserData() ?? UserModel();
      _nameController.text = userData.name ?? '';
      _emailController.text = userData.email ?? '';
      _bioController.text = userData.bio ?? '';
      _phoneController.text = userData.phone ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(saveUserProvider).getUserData() ?? UserModel();
    final isLoading = ref.watch(authProvider).isLoading ?? false;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: isDark
                        ? greenSwatch.shade700
                        : greenSwatch.shade100,
                    backgroundImage: _selectedImageBytes != null
                        ? MemoryImage(_selectedImageBytes!)
                        : userData.profileImage != null &&
                              userData.profileImage!.isNotEmpty
                        ? NetworkImage(userData.profileImage!)
                        : null,
                    child:
                        _selectedImageBytes == null &&
                            (userData.profileImage == null ||
                                userData.profileImage!.isEmpty)
                        ? Icon(Icons.person, size: 50, color: primaryColor)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isDark
                            ? greenSwatch.shade200
                            : greenSwatch.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          final image = await pickImageFromGallery();
                          if (image != null) {
                            final bytes = await image.readAsBytes();
                            setState(() {
                              _selectedImageBytes = bytes;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: isDark
                              ? greenSwatch.shade900
                              : greenSwatch.shade100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            MyTextField(
              labelText: 'Name',
              controller: _nameController,
              hintText: 'Enter your name',
              prefixIcon: Icon(Icons.person_outline),
            ),

            MyTextField(
              controller: _bioController,
              hintText: 'Tell us about yourself',
              maxLines: 3,

              prefixIcon: Icon(Icons.notes),
            ),
            MyTextField(
              controller: _emailController,

              hintText: 'email@example.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.email_outlined),
            ),

            MyTextField(
              controller: _phoneController,
              hintText: '+1 234 567 8900',
              maxLength: 20,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone is required';
                }

                return null;
              },

              textInputAction: TextInputAction.done,

              keyboardType: TextInputType.phone,
              prefixIcon: Icon(Icons.phone_outlined),
            ),

            SizedBox(height: 24),

            CustomButton(
              text: 'Save Changes',
              isLoading: isLoading,
              onPressed: () async {
                // Save profile logic
                if (_formKey.currentState?.validate() ?? false) {
                  final userodel = UserModel(
                    name: _nameController.text,
                    bio: _bioController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    profileImage: userData.profileImage,
                    provider: userData.provider,
                    authType: userData.authType,
                    id: userData.id,
                  );
                  await ref
                      .read(authProvider.notifier)
                      .updateUserData(userodel);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
