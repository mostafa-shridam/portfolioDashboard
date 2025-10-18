import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature/home/data/providers/home_provider.dart';
import '../models/user_model.dart';
import '../models/draggable_element_model.dart';
import '../services/firebase_template_service.dart';
import '../widgets/draggable_element.dart';
import '../theme/style.dart';

class ModernMinimalistTemplate extends ConsumerStatefulWidget {
  final UserModel userData;
  final bool isEditable;

  const ModernMinimalistTemplate({
    super.key,
    required this.userData,
    this.isEditable = false,
  });

  @override
  ConsumerState<ModernMinimalistTemplate> createState() =>
      _ModernMinimalistTemplateState();
}

class _ModernMinimalistTemplateState
    extends ConsumerState<ModernMinimalistTemplate> {
  List<DraggableElementModel> _elements = [];
  final String _templateId = 'modern_minimalist';

  @override
  void initState() {
    super.initState();
    if (widget.isEditable) {
      _loadElements();
    }
  }

  Future<void> _loadElements() async {
    final elements = await FirebaseTemplateService.getTemplateElements(
      userId: widget.userData.id ?? '',
      templateId: _templateId,
    );
    setState(() {
      _elements = elements;
    });
  }

  DraggableElementModel _getElementPosition(String elementId) {
    try {
      return _elements.firstWhere((element) => element.id == elementId);
    } catch (e) {
      return DraggableElementModel(
        id: elementId,
        type: elementId,
        x: 0,
        y: 0,
        lastModified: DateTime.now(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final tempColor =
        ref.read(homeProviderProvider).colorCallback ?? primaryColor;

    if (widget.isEditable) {
      return Container(
        color: isDark ? greenSwatch.shade900 : Colors.grey[50],
        child: Stack(
          children: [
            // Background content
            SingleChildScrollView(
              padding: EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200), // Space for draggable elements
                  _buildStaticContent(context, isDark, textTheme, tempColor),
                ],
              ),
            ),
            // Draggable elements
            ..._buildDraggableElements(context, isDark, textTheme, tempColor),
          ],
        ),
      );
    }

    return Container(
      color: isDark ? greenSwatch.shade900 : Colors.grey[50],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        widget.userData.profileImage != null &&
                            widget.userData.profileImage!.isNotEmpty
                        ? NetworkImage(widget.userData.profileImage!)
                        : null,
                    child:
                        widget.userData.profileImage == null ||
                            widget.userData.profileImage!.isEmpty
                        ? Icon(Icons.person, size: 80)
                        : null,
                  ),
                  SizedBox(height: 24),
                  Text(
                    widget.userData.name ?? 'Your Name',
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.userData.bio?.isEmpty ?? true
                        ? 'Your professional tagline here'
                        : widget.userData.bio ??
                              'Your professional tagline here',
                    style: textTheme.bodyMedium?.copyWith(color: tempColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.email),
                        label: Text('Contact Me'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.download),
                        label: Text('Download CV'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: tempColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),

            // About Section
            _buildSection(
              context,
              title: 'About',
              content: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: isDark ? greenSwatch.shade800 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Clean, minimalist design focusing on content and readability. '
                  'Perfect for professionals who want their work to speak for itself.',
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 48),

            // Skills Section
            _buildSection(
              context,
              title: 'Skills',
              content: Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    [
                          'Flutter',
                          'Dart',
                          'Firebase',
                          'UI/UX Design',
                          'Mobile Development',
                        ]
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
                            backgroundColor: isDark
                                ? greenSwatch.shade800
                                : Colors.white,
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 48),

            // Projects Section
            _buildSection(
              context,
              title: 'Projects',
              content: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.5,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: isDark ? greenSwatch.shade800 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder, size: 48, color: primaryColor),
                          SizedBox(height: 12),
                          Text(
                            'Project ${index + 1}',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDraggableElements(
    BuildContext context,
    bool isDark,
    TextTheme textTheme,
    Color tempColor,
  ) {
    final avatarPosition = _getElementPosition('avatar');
    final namePosition = _getElementPosition('name');
    final bioPosition = _getElementPosition('bio');
    final buttonsPosition = _getElementPosition('buttons');

    return [
      // Avatar
      DraggableElement(
        elementId: 'avatar',
        elementType: 'avatar',
        userId: widget.userData.id ?? '',
        templateId: _templateId,
        initialX: avatarPosition.x,
        initialY: avatarPosition.y,
        isEditable: widget.isEditable,
        child: CircleAvatar(
          radius: 80,
          backgroundImage:
              widget.userData.profileImage != null &&
                  widget.userData.profileImage!.isNotEmpty
              ? NetworkImage(widget.userData.profileImage!)
              : null,
          child:
              widget.userData.profileImage == null ||
                  widget.userData.profileImage!.isEmpty
              ? Icon(Icons.person, size: 80)
              : null,
        ),
      ),

      // Name
      DraggableElement(
        elementId: 'name',
        elementType: 'text',
        userId: widget.userData.id ?? '',
        templateId: _templateId,
        initialX: namePosition.x,
        initialY: namePosition.y + 180,
        isEditable: widget.isEditable,
        child: Text(
          widget.userData.name ?? 'Your Name',
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      // Bio
      DraggableElement(
        elementId: 'bio',
        elementType: 'text',
        userId: widget.userData.id ?? '',
        templateId: _templateId,
        initialX: bioPosition.x,
        initialY: bioPosition.y + 220,
        isEditable: widget.isEditable,
        child: Container(
          width: 300,
          child: Text(
            widget.userData.bio?.isEmpty ?? true
                ? 'Your professional tagline here'
                : widget.userData.bio ?? 'Your professional tagline here',
            style: textTheme.bodyMedium?.copyWith(color: tempColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),

      // Buttons
      DraggableElement(
        elementId: 'buttons',
        elementType: 'buttons',
        userId: widget.userData.id ?? '',
        templateId: _templateId,
        initialX: buttonsPosition.x,
        initialY: buttonsPosition.y + 280,
        isEditable: widget.isEditable,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.email),
              label: Text('Contact Me'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download),
              label: Text('Download CV'),
              style: OutlinedButton.styleFrom(
                backgroundColor: tempColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildStaticContent(
    BuildContext context,
    bool isDark,
    TextTheme textTheme,
    Color tempColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About Section
        _buildSection(
          context,
          title: 'About',
          content: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDark ? greenSwatch.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Clean, minimalist design focusing on content and readability. '
              'Perfect for professionals who want their work to speak for itself.',
              style: textTheme.bodyMedium,
            ),
          ),
        ),
        SizedBox(height: 48),

        // Skills Section
        _buildSection(
          context,
          title: 'Skills',
          content: Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                [
                      'Flutter',
                      'Dart',
                      'Firebase',
                      'UI/UX Design',
                      'Mobile Development',
                    ]
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        backgroundColor: isDark
                            ? greenSwatch.shade800
                            : Colors.white,
                      ),
                    )
                    .toList(),
          ),
        ),
        SizedBox(height: 48),

        // Projects Section
        _buildSection(
          context,
          title: 'Projects',
          content: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.5,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: isDark ? greenSwatch.shade800 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder, size: 48, color: primaryColor),
                      SizedBox(height: 12),
                      Text('Project ${index + 1}', style: textTheme.bodyMedium),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget content,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodyMedium),
        SizedBox(height: 24),
        content,
      ],
    );
  }
}
