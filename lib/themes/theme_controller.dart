import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resonate/themes/theme_enum.dart';
import 'package:resonate/utils/constants.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'app_theme_color';
  static const String _brightnessKey = 'app_brightness_mode';
  
  final GetStorage _storage = GetStorage();

  // Reactive observables with proper initialization
  late final Rx<String> currentTheme;
  late final Rx<ThemeMode> brightness;
  late final Rx<String> currentThemePlaceHolder;

  bool _isInitialized = false;

  @override
  void onInit() {
    super.onInit();
    _initializeThemeState();
  }

  /// Initialize theme state with optimized loading
  void _initializeThemeState() {
    if (_isInitialized) return;

    // Batch load from storage for efficiency
    final savedTheme = _storage.read(_themeKey) ?? Themes.classic.name;
    final savedBrightness = _storage.read(_brightnessKey) ?? 'light';

    // Initialize reactives
    currentTheme = savedTheme.obs;
    brightness = (savedBrightness == 'light' ? ThemeMode.light : ThemeMode.dark).obs;
    currentThemePlaceHolder = _getPlaceholderForTheme(savedTheme).obs;

    _isInitialized = true;
    log('✓ Theme State Initialized: $savedTheme ($savedBrightness)');
  }

  /// Get placeholder ID for theme
  String _getPlaceholderForTheme(String themeName) {
    return switch (themeName) {
      "amber" => amberUserProfileImagePlaceholderID,
      "vintage" => vintageUserProfileImagePlaceholderID,
      "time" => timeUserProfileImagePlaceholderID,
      "classic" => classicUserProfileImagePlaceholderID,
      "forest" => forestUserProfileImagePlaceholderID,
      "cream" => creamUserProfileImagePlaceholderID,
      _ => classicUserProfileImagePlaceholderID,
    };
  }

  String get userProfileImagePlaceholderUrl =>
      "http://$baseDomain/v1/storage/buckets/$userProfileImageBucketId/files/${currentThemePlaceHolder.value}/view?project=resonate&mode=admin";

  /// Set color theme and update placeholder
  void setTheme(String newTheme) {
    currentTheme.value = newTheme;
    currentThemePlaceHolder.value = _getPlaceholderForTheme(newTheme);
    _storage.write(_themeKey, newTheme);
    log('✓ Theme changed to: $newTheme');
  }

  /// Toggle between light and dark mode
  void toggleBrightness() {
    setBrightness(
      brightness.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  /// Set specific brightness mode
  void setBrightness(ThemeMode mode) {
    brightness.value = mode;
    final modeString = mode == ThemeMode.light ? 'light' : 'dark';
    _storage.write(_brightnessKey, modeString);
    log('✓ Brightness changed to: $modeString');
  }

  /// Check if currently in light mode
  bool get isLightMode => brightness.value == ThemeMode.light;

  /// Check if currently in dark mode
  bool get isDarkMode => brightness.value == ThemeMode.dark;
}
