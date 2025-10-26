import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/models/about.dart';
import '../../../../core/models/education.dart';
import '../../../../core/models/experience.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/my_text_filed.dart';
import '../../data/providers/about_provider.dart';

class AboutWidget extends ConsumerStatefulWidget {
  const AboutWidget({super.key, required this.selectedColor});
  final int selectedColor;
  @override
  ConsumerState<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends ConsumerState<AboutWidget> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  // Basic info controllers
  final _bioController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _locationController = TextEditingController();

  // Lists for complex data
  List<Experience> _workExperiences = [];
  List<Education> _educations = [];
  bool _isAvailableForWork = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(aboutProviderProvider.notifier).getWorkExperience();
      await ref.read(aboutProviderProvider.notifier).getAboutData();
    });
    _loadExistingData();
  }

  void _loadExistingData() {
    final aboutData = ref.read(aboutProviderProvider.select((e) => e.about));
    if (aboutData != null) {
      _bioController.text = aboutData.bio ?? '';
      _jobTitleController.text = aboutData.jobTitle ?? '';
      _locationController.text = aboutData.location ?? '';
      _isAvailableForWork = aboutData.isAvailableForWork ?? true;
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Section
            _buildSectionTitle('Basic Information'),
            const SizedBox(height: 16),

            MyTextField(
              controller: _bioController,
              hintText: 'Tell us about yourself...',
              maxLines: 4,
              minLines: 2,
              maxLength: 500,
              labelText: 'About',
              prefixIcon: FontAwesomeIcons.user,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your bio';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            MyTextField(
              controller: _jobTitleController,
              hintText: 'e.g., Flutter Developer',
              labelText: 'Job Title',
              prefixIcon: FontAwesomeIcons.briefcase,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your job title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            MyTextField(
              controller: _locationController,
              hintText: 'e.g., Cairo, Egypt',
              labelText: 'Location',
              prefixIcon: FontAwesomeIcons.locationDot,
            ),
            const SizedBox(height: 16),

            // Availability Switch
            SwitchListTile(
              title: const Text('Available for work'),
              subtitle: Text(
                _isAvailableForWork
                    ? 'You are available for new opportunities'
                    : 'You are not available for work',
              ),
              value: _isAvailableForWork,
              onChanged: (value) {
                setState(() {
                  _isAvailableForWork = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Work Experience Section
            _buildSectionTitle('Work Experience'),
            const SizedBox(height: 16),
            ..._workExperiences.asMap().entries.map((entry) {
              final index = entry.key;
              final experience = entry.value;
              return _buildExperienceCard(experience, index);
            }),
            _buildAddButton(
              'Add Work Experience',
              FontAwesomeIcons.briefcase,
              _addWorkExperience,
            ),
            const SizedBox(height: 24),

            // Education Section
            _buildSectionTitle('Education'),
            const SizedBox(height: 16),
            ..._educations.asMap().entries.map((entry) {
              final index = entry.key;
              final education = entry.value;
              return _buildEducationCard(education, index);
            }),
            _buildAddButton(
              'Add Education',
              FontAwesomeIcons.graduationCap,
              _addEducation,
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                isLoading: ref.watch(
                  aboutProviderProvider.select((e) => e.isLoading ?? false),
                ),
                onPressed: _saveAboutData,
                text: 'Save About Information',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAddButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Experience experience, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${experience.position ?? 'Position'} at ${experience.company ?? 'Company'}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _editWorkExperience(index),
                  icon: const Icon(Icons.edit, size: 20),
                ),
                IconButton(
                  onPressed: () => _removeWorkExperience(index),
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                ),
              ],
            ),
            if (experience.location != null) ...[
              const SizedBox(height: 4),
              Text(
                experience.location!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
            if (experience.startDate != null || experience.endDate != null) ...[
              const SizedBox(height: 4),
              Text(
                '${experience.startDate ?? 'Start'} - ${experience.isCurrent == true ? 'Present' : experience.endDate ?? 'End'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (experience.description != null) ...[
              const SizedBox(height: 8),
              Text(
                experience.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(Education education, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${education.degree ?? 'Degree'} in ${education.field ?? 'Field'}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _editEducation(index),
                  icon: const Icon(Icons.edit, size: 20),
                ),
                IconButton(
                  onPressed: () => _removeEducation(index),
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                ),
              ],
            ),
            if (education.institution != null) ...[
              const SizedBox(height: 4),
              Text(
                education.institution!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
            if (education.startDate != null || education.endDate != null) ...[
              const SizedBox(height: 4),
              Text(
                '${education.startDate ?? 'Start'} - ${education.endDate ?? 'End'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (education.gpa != null) ...[
              const SizedBox(height: 4),
              Text(
                'GPA: ${education.gpa}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _addWorkExperience() {
    _showExperienceDialog();
  }

  void _editWorkExperience(int index) {
    _showExperienceDialog(experience: _workExperiences[index], index: index);
  }

  void _removeWorkExperience(int index) {
    setState(() {
      _workExperiences.removeAt(index);
    });
  }

  void _addEducation() {
    _showEducationDialog();
  }

  void _editEducation(int index) {
    _showEducationDialog(education: _educations[index], index: index);
  }

  void _removeEducation(int index) {
    setState(() {
      _educations.removeAt(index);
    });
  }

  void _showExperienceDialog({Experience? experience, int? index}) {
    final companyController = TextEditingController(
      text: experience?.company ?? '',
    );
    final positionController = TextEditingController(
      text: experience?.position ?? '',
    );
    final locationController = TextEditingController(
      text: experience?.location ?? '',
    );
    final descriptionController = TextEditingController(
      text: experience?.description ?? '',
    );
    final startDateController = TextEditingController(
      text: experience?.startDate ?? '',
    );
    final endDateController = TextEditingController(
      text: experience?.endDate ?? '',
    );
    bool isCurrent = experience?.isCurrent ?? false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            experience == null ? 'Add Work Experience' : 'Edit Work Experience',
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    controller: companyController,
                    labelText: 'Company',
                  ),
                  const SizedBox(height: 8),
                  MyTextField(
                    controller: positionController,
                    labelText: 'Position',
                  ),
                  const SizedBox(height: 8),
                  MyTextField(
                    controller: locationController,
                    labelText: 'Location',
                  ),
                  const SizedBox(height: 8),
                  MyTextField(
                    controller: descriptionController,
                    labelText: 'Description',
                    maxLines: 3,
                    minLines: 1,
                  ),
                  const SizedBox(height: 8),
                  MyTextField(
                    controller: startDateController,
                    labelText: 'Start Date',
                  ),
                  const SizedBox(height: 8),
                  if (!isCurrent)
                    MyTextField(
                      controller: endDateController,
                      labelText: 'End Date',
                    ),
                  CheckboxListTile(
                    title: const Text('Current Position'),
                    value: isCurrent,
                    onChanged: (value) {
                      setDialogState(() {
                        isCurrent = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            CustomButton(
              text: 'Save',
              onPressed: () async {
                final newExperience = Experience(
                  company: companyController.text,
                  position: positionController.text,
                  location: locationController.text.isEmpty
                      ? null
                      : locationController.text,
                  description: descriptionController.text.isEmpty
                      ? null
                      : descriptionController.text,
                  startDate: startDateController.text.isEmpty
                      ? null
                      : startDateController.text,
                  endDate: isCurrent
                      ? null
                      : (endDateController.text.isEmpty
                            ? null
                            : endDateController.text),
                  isCurrent: isCurrent,
                );
                if (index != null) {
                  _workExperiences[index] = newExperience;
                } else {
                  _workExperiences.add(newExperience);
                  await ref
                      .read(aboutProviderProvider.notifier)
                      .addWorkExperience(newExperience);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEducationDialog({Education? education, int? index}) {
    final institutionController = TextEditingController(
      text: education?.institution ?? '',
    );
    final degreeController = TextEditingController(
      text: education?.degree ?? '',
    );
    final fieldController = TextEditingController(text: education?.field ?? '');
    final locationController = TextEditingController(
      text: education?.location ?? '',
    );
    final descriptionController = TextEditingController(
      text: education?.description ?? '',
    );
    final startDateController = TextEditingController(
      text: education?.startDate ?? '',
    );
    final endDateController = TextEditingController(
      text: education?.endDate ?? '',
    );
    final gpaController = TextEditingController(
      text: education?.gpa?.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(education == null ? 'Add Education' : 'Edit Education'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: institutionController,
                decoration: const InputDecoration(labelText: 'Institution'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: degreeController,
                decoration: const InputDecoration(labelText: 'Degree'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: fieldController,
                decoration: const InputDecoration(labelText: 'Field of Study'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: gpaController,
                decoration: const InputDecoration(labelText: 'GPA'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newEducation = Education(
                id: education?.id ?? _uuid.v4(),
                institution: institutionController.text,
                degree: degreeController.text,
                field: fieldController.text,
                location: locationController.text.isEmpty
                    ? null
                    : locationController.text,
                description: descriptionController.text.isEmpty
                    ? null
                    : descriptionController.text,
                startDate: startDateController.text.isEmpty
                    ? null
                    : startDateController.text,
                endDate: endDateController.text.isEmpty
                    ? null
                    : endDateController.text,
                gpa: gpaController.text.isEmpty
                    ? null
                    : double.tryParse(gpaController.text),
              );

              setState(() {
                if (index != null) {
                  _educations[index] = newEducation;
                } else {
                  _educations.add(newEducation);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveAboutData() async {
    if (_formKey.currentState?.validate() ?? false) {
      final aboutModel = AboutModel(
        bio: _bioController.text,
        jobTitle: _jobTitleController.text,
        location: _locationController.text.isEmpty
            ? null
            : _locationController.text,
        isAvailableForWork: _isAvailableForWork,
      );

      try {
        await ref.read(aboutProviderProvider.notifier).addAboutData(aboutModel);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('About information saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving data: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
