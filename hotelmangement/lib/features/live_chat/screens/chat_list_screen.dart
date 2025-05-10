import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_screen.dart';
import '../constants/app_colors.dart';

class ChatListScreen extends StatelessWidget {
  final bool isAdmin; // Pass true if admin, false if user
  final String? hotelId; // Required if admin to filter chats

  ChatListScreen({this.isAdmin = false, this.hotelId});

 @override
Widget build(BuildContext context) {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    return Scaffold(
      body: Center(child: Text('Please log in to see chats')),
    );
  }

  // Ensure hotelId is not null if isAdmin
  if (isAdmin && (hotelId == null || hotelId!.isEmpty)) {
    return Scaffold(
      body: Center(child: Text('Hotel ID is required for admin')),
    );
  }

  final query = isAdmin
      ? Supabase.instance.client
          .from('chats')
          .select('id, user_id, profile: user_id (username)')
          .eq('hotel_id', hotelId as Object) // <-- Cast to Object
      : Supabase.instance.client
          .from('chats')
          .select('id, hotel_id, hotel: hotel_id (name)')
          .eq('user_id', user.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 1,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: query,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chats available'));
          }

          final chats = snapshot.data!;

          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.accent.withOpacity(0.3),
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final chat = chats[index];
              final title = isAdmin
                  ? (chat['profile'] != null && chat['profile']['username'] != null
                      ? chat['profile']['username']
                      : 'User')
                  : (chat['hotel'] != null && chat['hotel']['name'] != null
                      ? chat['hotel']['name']
                      : 'Hotel');

              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(title, style: const TextStyle(fontSize: 18)),
                leading: CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  child: const Icon(Icons.hotel, color: Colors.white),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        chatId: chat['id'],
                        chatTitle: title,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
