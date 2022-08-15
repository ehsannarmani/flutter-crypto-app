import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/providers/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider themeProvider = Provider.of(context);
    var icon = themeProvider.isDarkMode ? Icons.sunny : Icons.nightlight_round;

    return  IconButton(
        onPressed: themeProvider.toggleTheme,
        icon: Icon(icon)
    );
  }
}
