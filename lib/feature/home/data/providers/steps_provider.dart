import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/style.dart';

part 'generated/steps_provider.g.dart';

@riverpod
class StepsProvider extends _$StepsProvider {
  @override
  StepsState build() {
    return StepsState(
      currentStep: 0,
      totalSteps: 0,
      showNumbers: true,
      showLabels: true,
      labels: ['الخطوة 1', 'الخطوة 2', 'الخطوة 3', 'الخطوة 4', 'الخطوة 5'],
      isLoading: false,
      isCompleted: false,
      isFailed: false,
    );
  }

  void updateSteps(int currentStep) {
    state = state.copyWith(isLoading: true);
    try {
      final stepLabel = getStepLabel(currentStep);

      state = state.copyWith(
        currentStep: currentStep + 1,
        labels: [stepLabel],
        isLoading: false,
      );
      log('updateSteps: $currentStep');
    } catch (e) {
      log('error in updateSteps: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void completeSteps() {
    state = state.copyWith(isCompleted: true);
  }

  void failSteps() {
    state = state.copyWith(isFailed: true);
  }

  void resetSteps() {
    state = state.copyWith(isCompleted: false, isFailed: false);
  }

  String getStepLabel(int currentStep) {
    if (currentStep > 4) {
      return 'الخطوة 5';
    }
    switch (currentStep) {
      case 0:
        return 'الخطوة 1';
      case 1:
        return 'الخطوة 2';
      case 2:
        return 'الخطوة 3';
      case 3:
        return 'الخطوة 4';
      case 4:
        return 'الخطوة 5';

      default:
        return 'الخطوة 1';
    }
  }

  int getStepColor(int currentStep) {
    if (currentStep > 4) {
      return primaryColor.toARGB32();
    }
    switch (currentStep) {
      case 0:
        return primaryColor.toARGB32();
      case 1:
        return greenColor.toARGB32();
      case 2:
        return primaryColor.toARGB32();
      case 3:
        return greenColor.toARGB32();
      case 4:
        return primaryColor.toARGB32();

      default:
        return primaryColor.toARGB32();
    }
  }

  int getTotalSteps() {
    if (state.currentStep == 4) {
      return 5;
    }
    return state.currentStep ?? 0;
  }
}

class StepsState {
  int? currentStep;
  int? totalSteps;
  bool? showNumbers;
  bool? showLabels;
  bool? isLoading;
  bool? isCompleted;
  bool? isFailed;
  Animation<double>? animation;
  AnimationController? animationController;
  Duration? animationDuration;
  CurvedAnimation? curvedAnimation;

  double? lineHeight;
  double? stepSize;
  List<String>? labels;
  StepsState({
    this.currentStep,
    this.totalSteps,
    this.showNumbers,
    this.showLabels,
    this.labels,
    this.isLoading,
    this.isCompleted,
    this.isFailed,
    this.animation,
    this.animationController,
    this.animationDuration,
    this.curvedAnimation,
    this.lineHeight,
    this.stepSize,
  });
  StepsState copyWith({
    int? currentStep,
    int? totalSteps,
    bool? showNumbers,
    bool? showLabels,
    bool? isLoading,
    List<String>? labels,
    bool? isCompleted,
    bool? isFailed,
    Animation<double>? animation,
    AnimationController? animationController,
    Duration? animationDuration,
    CurvedAnimation? curvedAnimation,
    double? lineHeight,
    double? stepSize,
  }) {
    return StepsState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      showNumbers: showNumbers ?? this.showNumbers,
      showLabels: showLabels ?? this.showLabels,
      labels: labels ?? this.labels,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      isFailed: isFailed ?? this.isFailed,
      animation: animation ?? this.animation,
      animationController: animationController ?? this.animationController,
      animationDuration: animationDuration ?? this.animationDuration,
      curvedAnimation: curvedAnimation ?? this.curvedAnimation,
      lineHeight: lineHeight ?? this.lineHeight,
      stepSize: stepSize ?? this.stepSize,
    );
  }
}
