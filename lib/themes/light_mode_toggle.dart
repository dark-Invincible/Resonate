import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resonate/themes/theme_controller.dart';

/// Customizable brightness toggle widget
class BrightnessToggle extends StatelessWidget {
  final ThemeController _themeController = Get.find<ThemeController>();

  /// Style variants for the toggle
  final BrightnessToggleStyle style;

  /// Custom colors
  final Color? activeColor;
  final Color? inactiveColor;

  /// Custom icon sizes (for icon-based styles)
  final double iconSize;

  /// Callback when brightness changes
  final VoidCallback? onChanged;

  BrightnessToggle({
    super.key,
    this.style = BrightnessToggleStyle.switchTile,
    this.activeColor,
    this.inactiveColor,
    this.iconSize = 24,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLight = _themeController.isLightMode;

      return switch (style) {
        BrightnessToggleStyle.switchTile => _buildSwitchTile(isLight, context),
        BrightnessToggleStyle.fab => _buildFAB(isLight),
        BrightnessToggleStyle.iconButton => _buildIconButton(isLight),
        BrightnessToggleStyle.compactButton => _buildCompactButton(isLight, context),
        BrightnessToggleStyle.segmentedButton => _buildSegmentedButton(isLight),
      };
    });
  }

  /// Switch tile style (for settings)
  Widget _buildSwitchTile(bool isLight, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: SwitchListTile(
        title: const Text('Light Mode'),
        subtitle: Text(isLight ? 'Light mode enabled' : 'Dark mode enabled'),
        value: isLight,
        onChanged: (_) => _toggle(),
        secondary: Icon(
          isLight ? Icons.light_mode : Icons.dark_mode,
          color: activeColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  /// Floating action button style
  Widget _buildFAB(bool isLight) {
    return FloatingActionButton(
      onPressed: _toggle,
      backgroundColor: activeColor,
      tooltip: 'Toggle ${isLight ? 'Dark' : 'Light'} Mode',
      child: Icon(
        isLight ? Icons.dark_mode : Icons.light_mode,
        size: iconSize,
      ),
    );
  }

  /// Simple icon button
  Widget _buildIconButton(bool isLight) {
    return IconButton(
      icon: Icon(
        isLight ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        size: iconSize,
      ),
      onPressed: _toggle,
      tooltip: 'Toggle Light/Dark Mode',
      color: activeColor,
    );
  }

  /// Compact button with background
  Widget _buildCompactButton(bool isLight, BuildContext context) {
    return InkWell(
      onTap: _toggle,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (activeColor ?? Theme.of(context).primaryColor).withAlpha(30),
        ),
        child: Icon(
          isLight ? Icons.dark_mode : Icons.light_mode,
          size: iconSize,
          color: activeColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  /// Segmented button style (modern)
  Widget _buildSegmentedButton(bool isLight) {
    return SegmentedButton<bool>(
      segments: [
        ButtonSegment(
          value: true,
          label: const Text('Light'),
          icon: const Icon(Icons.light_mode),
        ),
        ButtonSegment(
          value: false,
          label: const Text('Dark'),
          icon: const Icon(Icons.dark_mode),
        ),
      ],
      selected: {isLight},
      onSelectionChanged: (selected) {
        final newIsLight = selected.first;
        if (newIsLight != isLight) {
          _toggle();
        }
      },
    );
  }

  void _toggle() {
    _themeController.toggleBrightness();
    onChanged?.call();
  }
}

enum BrightnessToggleStyle {
  switchTile,
  fab,
  iconButton,
  compactButton,
  segmentedButton,
}

/// Backward compatibility aliases
@Deprecated('Use BrightnessToggle(style: BrightnessToggleStyle.switchTile) instead')
class LightModeToggle extends BrightnessToggle {
  LightModeToggle({super.key})
      : super(style: BrightnessToggleStyle.switchTile);
}

@Deprecated('Use BrightnessToggle(style: BrightnessToggleStyle.fab) instead')
class LightModeToggleButton extends BrightnessToggle {
  LightModeToggleButton({super.key}) : super(style: BrightnessToggleStyle.fab);
}

@Deprecated('Use BrightnessToggle(style: BrightnessToggleStyle.iconButton) instead')
class CompactLightModeToggle extends BrightnessToggle {
  CompactLightModeToggle({super.key})
      : super(style: BrightnessToggleStyle.iconButton);
}
