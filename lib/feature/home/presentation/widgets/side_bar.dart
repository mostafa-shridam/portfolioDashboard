import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/core/extensions/language.dart';
import 'package:userportfolio/feature/auth/data/providers/auth.dart';
import 'package:userportfolio/providers/settings.dart';

import '../../../../core/extensions/theme_mode.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/theme/style.dart';
import '../../data/providers/home_provider.dart';
import 'design_widget.dart';
import 'profile_widget.dart';
import 'toolbar_item.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({
    super.key,
    required this.userData,
  });
  final UserModel userData;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  bool _isDragging = false;
  double _dragStartX = 0.0;
  double _dragStartWidth = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize sidebar width if not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeState = ref.read(homeProviderProvider);
      if (homeState.sidebarWidth == null) {
        ref.read(homeProviderProvider.notifier).resetSidebarWidth();
      }
    });
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragStartX = details.globalPosition.dx;
      _dragStartWidth = ref.read(homeProviderProvider).sidebarWidth ?? 400.0;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final deltaX = details.globalPosition.dx - _dragStartX;
    // The handle is now on the left side of the sidebar, so:
    // - Drag right (positive deltaX) should decrease width (move handle away from sidebar)
    // - Drag left (negative deltaX) should increase width (move handle towards sidebar)
    final language = ref.watch(settingsProvider).language == Language.arabic;
    final newWidth = language
        ? _dragStartWidth - deltaX
        : _dragStartWidth + deltaX;
    // Apply constraints before updating
    final constrainedWidth = newWidth.clamp(400.0, 500.0);
    ref
        .read(homeProviderProvider.notifier)
        .updateSidebarWidth(constrainedWidth);

    // Update the drag start position for smooth continuous dragging
    _dragStartX = details.globalPosition.dx;
    _dragStartWidth = constrainedWidth;
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  List<String> getMenuTitles() {
    return ['Design', 'Profile', 'Projects', 'Skills', 'Courses', 'Experience'];
  }

  List<IconData> getMenuIcons() {
    return [
      Icons.design_services,
      Icons.person,
      Icons.folder,
      Icons.build,
      Icons.school,
      Icons.work,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sidebarWidth = ref.watch(homeProviderProvider).sidebarWidth ?? 400.0;
    final isSidebarVisible =
        ref.watch(homeProviderProvider).hideSidebar ?? true;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final language = ref.watch(settingsProvider).language;
    final selectedIndex = ref.watch(homeProviderProvider).selectedIndex ?? 0;
    return Row(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: isDark ? greenSwatch.shade900 : greenSwatch.shade300,
            border: Border(
              left: BorderSide(
                color: isDark ? greenSwatch.shade600 : Colors.grey[300]!,
                width: 1,
              ),
              right: BorderSide(
                color: isDark ? greenSwatch.shade600 : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),

          child: Column(
            children: List.generate(
              getMenuTitles().length,
              (index) => ToolbarItem(
                isSelected: selectedIndex == index,
                onTap: () {
                  if (!isSidebarVisible) {
                    ref.read(homeProviderProvider.notifier).toggleSidebar();
                  }

                  ref
                      .read(homeProviderProvider.notifier)
                      .updateSelectedIndex(index);
                },
                title: getMenuTitles()[index],
                icon: getMenuIcons()[index],
              ),
            ),
          ),
        ),
        if (isSidebarVisible) ...[
          Container(
            width: sidebarWidth,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: isDark ? greenSwatch.shade900 : whiteColor,
            ),
            child: Column(
              children: [
                // Sidebar header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? greenSwatch.shade900 : Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? greenSwatch.shade600
                            : greenSwatch.shade200,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sidebarWidth.toStringAsFixed(0),
                          style: textTheme.headlineSmall,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(authProvider.notifier)
                              .signOut(context);
                        },
                        icon: Icon(Icons.logout),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(settingsProvider.notifier)
                              .changeThemeMode(
                                isDark ? Thememode.light : Thememode.dark,
                              );
                        },
                        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                      ),
                      IconButton(
                        onPressed: () async {
                          final newLanguage = language == Language.arabic
                              ? Language.english
                              : Language.arabic;
                          await ref
                              .read(settingsProvider.notifier)
                              .changeLanguage(newLanguage);
                          if (context.mounted) {
                            await context.setLocale(
                              Language.getLanguageLocale(newLanguage),
                            );
                          }
                        },
                        icon: Icon(Icons.language),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(homeProviderProvider.notifier)
                              .toggleSidebar();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                // Sidebar content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedIndex == 0) ...[
                        Expanded(child: DesignWidget()),
                      ] else if (selectedIndex == 1) ...[
                        Expanded(child: ProfileWidget()),
                      ] else ...[
                        Expanded(
                          child: Center(
                            child: Text(
                              'Coming Soon',
                              style: textTheme.headlineSmall,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: 8,
                height: MediaQuery.of(context).size.height,
                color: _isDragging
                    ? isDark
                          ? greenSwatch.shade600.withAlpha(80)
                          : greenSwatch.shade200.withAlpha(80)
                    : Colors.transparent,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
