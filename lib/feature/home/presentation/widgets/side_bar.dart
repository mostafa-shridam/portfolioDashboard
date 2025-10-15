import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/local_service/save_user.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/theme/style.dart';
import '../../data/providers/home_provider.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({super.key, required this.userData});
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
      _dragStartWidth = ref.read(homeProviderProvider).sidebarWidth ?? 300.0;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final deltaX = details.globalPosition.dx - _dragStartX;
    // The handle is now on the left side of the sidebar, so:
    // - Drag right (positive deltaX) should decrease width (move handle away from sidebar)
    // - Drag left (negative deltaX) should increase width (move handle towards sidebar)
    final newWidth = _dragStartWidth - deltaX;

    // Apply constraints before updating
    final constrainedWidth = newWidth.clamp(200.0, 500.0);
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

  @override
  Widget build(BuildContext context) {
    final sidebarWidth = ref.watch(homeProviderProvider).sidebarWidth ?? 300.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final userData = widget.userData;
    return Row(
      children: [
        Container(
          width: sidebarWidth,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: isDark ? greenSwatch.shade900 : greenSwatch.shade100,
            border: Border(
              right: BorderSide(
                color: isDark ? greenSwatch.shade600 : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Sidebar header
              Container(
                height: 60,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? greenSwatch.shade900 : Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? greenSwatch.shade600
                          : greenSwatch.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Sidebar', style: textTheme.labelMedium),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(homeProviderProvider.notifier).toggleSidebar();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // Sidebar content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User: ${userData.name}',
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Email: $userData.email}',
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Phone: ${userData.phone}',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
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
                        ? greenSwatch.shade600.withAlpha(120)
                        : greenSwatch.shade200.withAlpha(120)
                  : Colors.transparent,
              child: Center(
                child: Container(
                  width: 4,
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _isDragging
                        ? (isDark ? greenSwatch.shade400 : greenSwatch.shade600)
                        : (isDark ? greenSwatch.shade600 : Colors.grey[400]),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
