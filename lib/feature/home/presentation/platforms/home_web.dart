import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/feature/home/data/providers/home_provider.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/theme/style.dart';
import '../widgets/side_bar.dart';
import '../widgets/template_preview.dart';
import '../widgets/toogle_button.dart';

class HomeWeb extends ConsumerWidget {
  const HomeWeb({super.key, required this.userData});
  final UserModel userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProviderProvider);
    final isSidebarVisible = homeState.hideSidebar ?? true;
    final selectedTemplateIndex = homeState.selectedTemplateIndex;
    final isEditMode = homeState.isEditMode ?? false;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideBar(userData: userData),
        // Toggle button when sidebar is hidden
        if (!isSidebarVisible) ToogleButton(),

        // Main content area - Display selected template
        Expanded(
          child: selectedTemplateIndex != null
              ? Stack(
                  children: [
                    TemplatePreview(
                      templateIndex: selectedTemplateIndex,
                      userData: userData,
                      isEditable: isEditMode,
                    ),
                    // Edit Mode Toggle Button
                    Positioned(
                      top: 16,
                      left: 16,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          ref
                              .read(homeProviderProvider.notifier)
                              .toggleEditMode();
                        },
                        backgroundColor: isEditMode
                            ? Colors.green
                            : primaryColor,
                        icon: Icon(
                          isEditMode ? Icons.visibility : Icons.edit,
                          color: Colors.white,
                        ),
                        label: Text(
                          isEditMode ? 'Preview' : 'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  color: isDark ? greenSwatch.shade900 : whiteColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.web_outlined,
                          size: 120,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Welcome to Your Portfolio Builder',
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Select a template from the Design section to get started',
                          style: textTheme.bodyLarge?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Open design section
                            ref
                                .read(homeProviderProvider.notifier)
                                .updateSelectedIndex(0);
                            if (!isSidebarVisible) {
                              ref
                                  .read(homeProviderProvider.notifier)
                                  .toggleSidebar();
                            }
                          },
                          icon: Icon(Icons.design_services),
                          label: Text('Browse Templates'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
