import 'package:flutter/material.dart';
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
    final constrainedWidth = width.clamp(400.0, 500.0);
    state = state.copyWith(sidebarWidth: constrainedWidth);
  }

  void resetSidebarWidth() {
    state = state.copyWith(sidebarWidth: 400.0);
  }

  void updateSelectedIndex(int index) {
    state = state.copyWith(isLoading: true);
    try {
      state = state.copyWith(selectedIndex: index, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void updateIsSeeAll(bool isSeeAll) {
    state = state.copyWith(isSeeAll: isSeeAll);
    try {
      state = state.copyWith(isSeeAll: isSeeAll, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void selectTemplate(int templateIndex, Color color) {
    state = state.copyWith(
      selectedTemplateIndex: templateIndex,
      colorCallback: color,
    );
  }

  void toggleEditMode() {
    state = state.copyWith(isEditMode: !(state.isEditMode ?? false));
  }
}

class HomeState {
  bool? isLoading;
  bool? hideSidebar;
  double? sidebarWidth;
  int? selectedIndex;
  bool? isSeeAll;
  Color? colorCallback;
  int? selectedTemplateIndex;
  bool? isEditMode;

  HomeState({
    this.isLoading,
    this.hideSidebar,
    this.sidebarWidth,
    this.selectedIndex,
    this.isSeeAll,
    this.colorCallback,
    this.selectedTemplateIndex,
    this.isEditMode,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? hideSidebar,
    double? sidebarWidth,
    int? selectedIndex,
    bool? isSeeAll,
    int? selectedTemplateIndex,
    Color? colorCallback,
    bool? isEditMode,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      hideSidebar: hideSidebar ?? this.hideSidebar,
      sidebarWidth: sidebarWidth ?? this.sidebarWidth,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isSeeAll: isSeeAll ?? this.isSeeAll,
      colorCallback: colorCallback ?? this.colorCallback,
      selectedTemplateIndex:
          selectedTemplateIndex ?? this.selectedTemplateIndex,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
