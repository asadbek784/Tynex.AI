import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/chat_provider.dart';
import '../../domain/models/chat_message.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);

    return Scaffold(
      drawer: const SidebarDrawer(),
      appBar: AppBar(
        title: Text('Tynex AI', style: GoogleFonts.orbitron(letterSpacing: 2)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.trash),
            onPressed: () => ref.read(chatProvider.notifier).clearChat(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Color(0xFF121212), Colors.black],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.cpu, size: 80, color: Colors.white24)
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .scale(delay: 200.ms),
                          const SizedBox(height: 20),
                          Text(
                            'How can I help you today?',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                            ),
                          ).animate().fadeIn(delay: 400.ms),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(20),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(message: messages[index]);
                      },
                    ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 60,
        borderRadius: 30,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      ref.read(chatProvider.notifier).sendMessage(value);
                      _controller.clear();
                      _scrollToBottom();
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Iconsax.send_1, color: Colors.white),
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    ref.read(chatProvider.notifier).sendMessage(_controller.text);
                    _controller.clear();
                    _scrollToBottom();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.cpu, size: 50, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      'TYNEX AI',
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(Iconsax.message, 'Chat', true),
            _buildDrawerItem(Iconsax.setting_2, 'Settings', false),
            _buildDrawerItem(Iconsax.info_circle, 'About', false),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'v1.0.0',
                style: GoogleFonts.poppins(color: Colors.white24, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool selected) {
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.white : Colors.white38),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: selected ? Colors.white : Colors.white38,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      onTap: () {},
    );
  }
}
