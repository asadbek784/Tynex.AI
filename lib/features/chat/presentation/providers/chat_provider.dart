import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/chat_message.dart';

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  void sendMessage(String content) async {
    final userMessage = ChatMessage(content: content, role: MessageRole.user);
    state = [...state, userMessage];

    // Simulate AI response
    await Future.delayed(const Duration(seconds: 1));
    final aiMessage = ChatMessage(
      content: "I am Tynex AI. How can I assist you today?",
      role: MessageRole.ai,
    );
    state = [...state, aiMessage];
  }

  void clearChat() {
    state = [];
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});
