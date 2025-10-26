import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:userportfolio/core/mixins/scaffold_messeneger.dart';
import 'package:userportfolio/core/theme/style.dart';

import '../../../../core/local_service/save_user.dart';
import '../../../../core/mixins/image_picker.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/models/social_links_model.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/my_text_filed.dart';
import '../../../../core/widgets/multi_select_language_field.dart';
import '../../../auth/data/providers/auth.dart';
import '../../data/providers/home_provider.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  const ProfileWidget({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ConsumerStatefulWidget>
    with ImagePickerMixin, ScaffoldMessengerMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _locationController = TextEditingController();
  final _resumeUrlController = TextEditingController();

  List<String> _selectedLanguages = [];
  // Social Links Controllers
  final _githubController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _facebookController = TextEditingController();
  final _twitterController = TextEditingController();
  final _instagramController = TextEditingController();
  final _websiteController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _behanceController = TextEditingController();
  final _dribbbleController = TextEditingController();

  Uint8List? _selectedImageBytes;
  String? _selectedImageUrl;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userData = ref.watch(saveUserProvider).getUserData() ?? UserModel();
      _nameController.text = userData.name ?? '';
      _emailController.text = userData.email ?? '';
      _bioController.text = userData.bio ?? '';
      _phoneController.text = userData.phone ?? '';
      _jobTitleController.text = userData.jobTitle ?? '';
      _locationController.text = userData.location ?? '';
      _resumeUrlController.text = userData.resumeUrl ?? '';
      _selectedLanguages = userData.languages ?? [];

      // Load social links
      final socialLinks = userData.socialLinks ?? SocialLinksModel();
      _githubController.text = socialLinks.githubUrl ?? '';
      _linkedinController.text = socialLinks.linkedinUrl ?? '';
      _facebookController.text = socialLinks.facebookUrl ?? '';
      _twitterController.text = socialLinks.twitterUrl ?? '';
      _instagramController.text = socialLinks.instagramUrl ?? '';
      _websiteController.text = socialLinks.websiteUrl ?? '';
      _youtubeController.text = socialLinks.youtubeUrl ?? '';
      _behanceController.text = socialLinks.behanceUrl ?? '';
      _dribbbleController.text = socialLinks.dribbbleUrl ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(saveUserProvider).getUserData() ?? UserModel();
    final isLoading =
        ref.watch(supabaseServiceProvider).getIsLoading ||
        ref.watch(authProvider.select((e) => e.isLoading ?? false));
    final selectedColor =
        ref.watch(homeProviderProvider).colorCallback?.toARGB32() ?? 0;
    final socialLinks = userData.socialLinks ?? SocialLinksModel();
    final dataChanged =
        _nameController.text != (userData.name ?? '') ||
        _bioController.text != (userData.bio ?? '') ||
        _emailController.text != (userData.email ?? '') ||
        _phoneController.text != (userData.phone ?? '') ||
        _jobTitleController.text != (userData.jobTitle ?? '') ||
        _locationController.text != (userData.location ?? '') ||
        _resumeUrlController.text != (userData.resumeUrl ?? '') ||
        !_listsEqual(_selectedLanguages, userData.languages ?? []) ||
        _githubController.text != (socialLinks.githubUrl ?? '') ||
        _linkedinController.text != (socialLinks.linkedinUrl ?? '') ||
        _facebookController.text != (socialLinks.facebookUrl ?? '') ||
        _twitterController.text != (socialLinks.twitterUrl ?? '') ||
        _instagramController.text != (socialLinks.instagramUrl ?? '') ||
        _websiteController.text != (socialLinks.websiteUrl ?? '') ||
        _youtubeController.text != (socialLinks.youtubeUrl ?? '') ||
        _behanceController.text != (socialLinks.behanceUrl ?? '') ||
        _dribbbleController.text != (socialLinks.dribbbleUrl ?? '') ||
        _selectedImageBytes != null ||
        _selectedImageUrl != null;
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
                              _selectedImageUrl = image.path.toString();
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              maxLength: 50,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              controller: _nameController,
              hintText: 'Enter your name',
              prefixIcon: FontAwesomeIcons.user,
            ),

            MyTextField(
              controller: _bioController,
              hintText: 'Tell us about yourself',
              maxLines: 3,
              minLines: 1,
              maxLength: 140,
              labelText: 'Bio',
              prefixIcon: FontAwesomeIcons.filePen,
            ),
            MyTextField(
              controller: _emailController,
              validator: defaultEmailValidator,
              labelText: 'Email',
              hintText: 'email@example.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: FontAwesomeIcons.envelope,
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
                if (value.length < 10) {
                  return 'Phone must be at least 10 digits';
                }
                return null;
              },

              textInputAction: TextInputAction.done,
              labelText: 'Phone',
              keyboardType: TextInputType.phone,
              prefixIcon: FontAwesomeIcons.phone,
            ),

            // Job Title
            MyTextField(
              controller: _jobTitleController,
              labelText: 'Job Title',
              hintText: 'Enter your job title',
              keyboardType: TextInputType.text,
              prefixIcon: FontAwesomeIcons.briefcase,
            ),

            // Location
            MyTextField(
              controller: _locationController,
              labelText: 'Location',
              hintText: 'Enter your location',
              keyboardType: TextInputType.text,
              prefixIcon: FontAwesomeIcons.locationDot,
            ),
            // Resume URL
            MyTextField(
              controller: _resumeUrlController,
              labelText: 'Resume URL',
              hintText: 'https://drive.google.com/file/d/...',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.filePdf,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),
            // Languages
            MultiSelectLanguageField(
              selectedLanguageCodes: _selectedLanguages,
              onChanged: (languages) {
                setState(() {
                  _selectedLanguages = languages;
                });
              },
              labelText: 'Languages',
              hintText: 'Select your languages',
              prefixIcon: Icon(FontAwesomeIcons.language, size: 18),
            ),
            // Social Links Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Social Links',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            MyTextField(
              controller: _githubController,
              labelText: 'GitHub',
              hintText: 'https://github.com/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.github,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _linkedinController,
              labelText: 'LinkedIn',
              hintText: 'https://linkedin.com/in/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.linkedin,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _websiteController,
              labelText: 'Website',
              hintText: 'https://yourwebsite.com',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.globe,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _facebookController,
              labelText: 'Facebook',
              hintText: 'https://facebook.com/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.facebook,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _twitterController,
              labelText: 'Twitter/X',
              hintText: 'https://twitter.com/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.twitter,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _instagramController,
              labelText: 'Instagram',
              hintText: 'https://instagram.com/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.instagram,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _youtubeController,
              labelText: 'YouTube',
              hintText: 'https://youtube.com/channel/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.youtube,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _behanceController,
              labelText: 'Behance',
              hintText: 'https://behance.net/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.behance,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            MyTextField(
              controller: _dribbbleController,
              labelText: 'Dribbble',
              hintText: 'https://dribbble.com/username',
              keyboardType: TextInputType.url,
              prefixIcon: FontAwesomeIcons.dribbble,
              validator: (value) {
                if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),

            SizedBox(height: 24),

            CustomButton(
              text: 'Save Changes',
              isLoading: isLoading,

              onPressed: () async {
                if (!dataChanged) {
                  showSnackBar(
                    context: context,
                    message: 'No changes made',
                    color: selectedColor,
                  );
                  FocusScope.of(context).unfocus();
                  return;
                }

                if (_formKey.currentState?.validate() ?? false) {
                  String? imageUrl;
                  if (_selectedImageBytes != null &&
                      _selectedImageBytes!.isNotEmpty) {
                    final originalFileName =
                        'profile_${DateTime.now().millisecondsSinceEpoch}.png';
                    log('uploading image: $originalFileName');

                    imageUrl = await ref
                        .watch(supabaseServiceProvider)
                        .uploadImage(
                          file: _selectedImageBytes!,
                          originalFileName: originalFileName,
                        );

                    log('imageUrl: $imageUrl');
                    if (imageUrl != null) {
                      setState(() {
                        _selectedImageUrl = imageUrl;
                        _selectedImageBytes = null;
                      });
                      userData.profileImage = imageUrl;
                    }
                  }

                  final updatedSocialLinks = SocialLinksModel(
                    githubUrl: _githubController.text.isEmpty
                        ? null
                        : _githubController.text,
                    linkedinUrl: _linkedinController.text.isEmpty
                        ? null
                        : _linkedinController.text,
                    facebookUrl: _facebookController.text.isEmpty
                        ? null
                        : _facebookController.text,
                    twitterUrl: _twitterController.text.isEmpty
                        ? null
                        : _twitterController.text,
                    instagramUrl: _instagramController.text.isEmpty
                        ? null
                        : _instagramController.text,
                    websiteUrl: _websiteController.text.isEmpty
                        ? null
                        : _websiteController.text,
                    youtubeUrl: _youtubeController.text.isEmpty
                        ? null
                        : _youtubeController.text,
                    behanceUrl: _behanceController.text.isEmpty
                        ? null
                        : _behanceController.text,
                    dribbbleUrl: _dribbbleController.text.isEmpty
                        ? null
                        : _dribbbleController.text,
                  );

                  final updatedUser = UserModel(
                    name: _nameController.text,
                    bio: _bioController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    jobTitle: _jobTitleController.text.isEmpty
                        ? null
                        : _jobTitleController.text,
                    location: _locationController.text.isEmpty
                        ? null
                        : _locationController.text,
                    resumeUrl: _resumeUrlController.text.isEmpty
                        ? null
                        : _resumeUrlController.text,
                    languages: _selectedLanguages.isEmpty
                        ? null
                        : _selectedLanguages,
                    profileImage: userData.profileImage,
                    provider: userData.provider,
                    authType: userData.authType,
                    id: userData.id,
                    socialLinks: updatedSocialLinks,
                  );

                  await ref
                      .read(authProvider.notifier)
                      .updateUserData(updatedUser);
                  if (context.mounted) {
                    showSnackBar(
                      context: context,
                      message: 'Profile updated successfully!',
                      color: selectedColor,
                    );
                  }
                }
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    _resumeUrlController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _facebookController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    _websiteController.dispose();
    _youtubeController.dispose();
    _behanceController.dispose();
    _dribbbleController.dispose();
    super.dispose();
  }

  bool _listsEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
