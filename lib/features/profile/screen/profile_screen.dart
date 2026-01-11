import 'package:flutter/material.dart';
import 'package:fly/features/auth/provider/auth_provider.dart'; // Changed
import 'package:fly/features/profile/widget/profile_body.dart';
import 'package:fly/features/profile/widget/profile_header.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.isSetHeader = false});
  final bool isSetHeader;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>(); // Changed

      // Only fetch if user data is not already loaded
      if (authProvider.user == null && authProvider.token != null) {
        try {
          await authProvider.fetchUser();
        } catch (e) {
          debugPrint("Error fetching user: $e");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load profile: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>(); // Changed
    final user = authProvider.user; // Changed
    final isLoading = user == null && authProvider.token != null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: widget.isSetHeader ? const ProfileHeader(isSet: true) : null,
      body: SafeArea(
        top: !widget.isSetHeader,
        child: Padding(
          padding: EdgeInsets.only(top: widget.isSetHeader ? 0 : 60),
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (user == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Failed to load user!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () async {
                          try {
                            await authProvider.fetchUser();
                          } catch (e) {
                            debugPrint("Retry failed: $e");
                          }
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else {
                // ✅ ProfileBody now gets user from AuthProvider directly
                return const ProfileBody();
              }
            },
          ),
        ),
      ),
    );
  }
}