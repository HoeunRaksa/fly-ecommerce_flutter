import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/app_config.dart';
import '../../auth/provider/auth_provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () => context.pop(),
          ),
          CupertinoDialogAction(
            child: const Text(
              "Yes",
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
            onPressed: () async {
              context.pop();

              // Get AuthProvider
              final authProvider = context.read<AuthProvider>();

              // Show loading
              if (context.mounted) {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CupertinoActivityIndicator(radius: 20),
                  ),
                );
              }

              try {
                // Logout
                await authProvider.logout();

                // Close loading dialog and navigate
                if (context.mounted) {
                  context.pop(); // Close loading
                  context.go("/home");
                }
              } catch (e) {
                debugPrint('Logout error: $e');
                if (context.mounted) {
                  context.pop(); // Close loading
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout failed: $e'),
                      backgroundColor: CupertinoColors.destructiveRed,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Get user from AuthProvider
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    // ✅ Show loading if no user
    if (user == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            SizedBox(height: 16),
            Text('Loading profile...'),
          ],
        ),
      );
    }

    String capitalizeFirst(String? text) {
      if (text == null || text.isEmpty) return '';
      return text[0].toUpperCase() + text.substring(1);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                // ✅ Debug info (remove in production)
                if (const bool.fromEnvironment('dart.vm.product') == false)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Current: ${user.email}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Role: ${user.role}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Verified: ${user.isVerified}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                // Profile Image with edit button
                Stack(
                  children: [
                    SizedBox(
                      height: 140,
                      width: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: user.hasProfileImage
                            ? CachedNetworkImage(
                          imageUrl: user.profileImageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: CupertinoColors.systemGrey5,
                            child: const Icon(
                              CupertinoIcons.person_fill,
                              size: 60,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        )
                            : Container(
                          color: CupertinoColors.systemGrey5,
                          child: const Icon(
                            CupertinoIcons.person_fill,
                            size: 60,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Show image picker dialog
                          _showImagePickerDialog(context, authProvider);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CupertinoColors.activeBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: CupertinoColors.white,
                              width: 3,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.camera_fill,
                            size: 20,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  capitalizeFirst(user.name),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 6),

                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CupertinoColors.systemGrey,
                  ),
                ),

                const SizedBox(height: 8),

                // Role Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: user.role == 'admin'
                        ? CupertinoColors.systemPurple.withOpacity(0.2)
                        : CupertinoColors.systemBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.role.toUpperCase(),
                    style: TextStyle(
                      color: user.role == 'admin'
                          ? CupertinoColors.systemPurple
                          : CupertinoColors.systemBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Column(
                  children: [
                    item(
                      context,
                      CupertinoIcons.person,
                      "Personal Information",
                      onPress: () {
                        // Navigate to edit profile
                        context.push('/edit-profile');
                      },
                    ),
                    item(
                      context,
                      CupertinoIcons.creditcard,
                      "Payment Method",
                      onPress: () {},
                    ),
                    item(
                      context,
                      CupertinoIcons.shopping_cart,
                      "Order History",
                      onPress: () {},
                    ),
                    item(
                      context,
                      CupertinoIcons.location,
                      "Address",
                      onPress: () {},
                    ),
                    item(
                      context,
                      CupertinoIcons.headphones,
                      "Support Center",
                      onPress: () {},
                    ),
                    const SizedBox(height: 20),
                    EleButton(
                      name: "Logout",
                      onPressed: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context, AuthProvider authProvider) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Change Profile Picture'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              context.pop();
              // TODO: Implement camera capture
              debugPrint('Take photo');
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.camera, color: CupertinoColors.activeBlue),
                SizedBox(width: 8),
                Text('Take Photo'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              context.pop();
              // TODO: Implement gallery picker
              debugPrint('Choose from gallery');
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.photo, color: CupertinoColors.activeBlue),
                SizedBox(width: 8),
                Text('Choose from Gallery'),
              ],
            ),
          ),
          if (authProvider.user?.hasProfileImage == true)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () async {
                context.pop();

                // Show loading
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CupertinoActivityIndicator(radius: 20),
                  ),
                );

                try {
                  await authProvider.deleteProfileImage();

                  if (context.mounted) {
                    context.pop(); // Close loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile picture removed'),
                        backgroundColor: CupertinoColors.systemGreen,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.pop(); // Close loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to remove picture: $e'),
                        backgroundColor: CupertinoColors.destructiveRed,
                      ),
                    );
                  }
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.delete),
                  SizedBox(width: 8),
                  Text('Remove Photo'),
                ],
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Widget item(
      BuildContext context,
      IconData icon,
      String information, {
        required VoidCallback onPress,
      }) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(10),
        onPressed: onPress,
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.systemGrey, size: 28),
            const SizedBox(width: 18),
            Text(
              information,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_forward,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }
}