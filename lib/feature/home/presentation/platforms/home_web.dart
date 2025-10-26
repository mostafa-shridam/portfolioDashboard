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
          child: TemplatePreview(
            templateIndex: selectedTemplateIndex ?? 0,
            userData: userData,
          ),
        ),
      ],
    );
  }
}
