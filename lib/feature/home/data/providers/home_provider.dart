import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/home_provider.g.dart';

@riverpod
class HomeProvider extends _$HomeProvider {
  @override
  HomeState build() {
    return HomeState();
  }

  void toggleSidebar() {
    state = state.copyWith(isLoading: true);
    try {
      state = state.copyWith(hideSidebar: !(state.hideSidebar ?? true));
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void updateSidebarWidth(double width) {
    // Ensure minimum and maximum width constraints
    final constrainedWidth = width.clamp(200.0, 500.0);
    state = state.copyWith(sidebarWidth: constrainedWidth);
  }

  void resetSidebarWidth() {
    state = state.copyWith(sidebarWidth: 300.0);
  }
}

class HomeState {
  bool? isLoading;
  bool? hideSidebar;
  double? sidebarWidth;

  HomeState({this.isLoading, this.hideSidebar, this.sidebarWidth});

  HomeState copyWith({
    bool? isLoading,
    bool? hideSidebar,
    double? sidebarWidth,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      hideSidebar: hideSidebar ?? this.hideSidebar,
      sidebarWidth: sidebarWidth ?? this.sidebarWidth,
    );
  }
}
