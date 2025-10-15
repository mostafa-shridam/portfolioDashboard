import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/feature/home/data/providers/home_provider.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/theme/style.dart';
import '../widgets/side_bar.dart';

class HomeWeb extends ConsumerWidget {
  const HomeWeb({super.key, required this.userData});
  final UserModel userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProviderProvider);
    final isSidebarVisible = homeState.hideSidebar ?? true;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        if (isSidebarVisible) SideBar(userData: userData),
        // Toggle button when sidebar is hidden
        if (!isSidebarVisible)
          InkWell(
            onTap: () {
              ref.read(homeProviderProvider.notifier).toggleSidebar();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(120),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.menu, color: Colors.grey[700]),
            ),
          ),
        // Main content area
        Expanded(
          child: Container(
            color: isDark ? greenSwatch.shade900 : greenSwatch.shade100,
            child: Center(
              child: Text('Main Content Area', style: textTheme.headlineMedium),
            ),
          ),
        ),
      ],
    );
  }
}
