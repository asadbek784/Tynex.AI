
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/chat/presentation/pages/chat_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TynexAI(),
    ),
  );
}

class TynexAI extends StatelessWidget {
  const TynexAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tynex AI',
      theme: AppTheme.darkTheme,
      home: const ChatPage(),
    );
  }
}
