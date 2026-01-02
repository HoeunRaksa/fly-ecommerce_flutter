import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../model/user_auth.dart';
class ProfileBody extends StatelessWidget {
  final User user;
  const ProfileBody({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    String capitalizeFirst(String? text) {
      if (text == null || text.isEmpty) return '';
      return text[0].toUpperCase() + text.substring(1);
    }
    final ImageProvider imageProvider = user.profileImage != null && user.profileImage!.isNotEmpty
    ?NetworkImage(AppConfig.getImageUrl(user.profileImage!)) : const AssetImage("${AppConfig.imageUrl}/character.png");
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
               children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    child: Image(image: imageProvider),
                  ),
                ),
                 SizedBox(height: 10,),
                 Text(capitalizeFirst(user.name), style: Theme.of(context).textTheme.headlineMedium,),
                 SizedBox(height: 10,),
                 Text("This this the extra information or bio", style: Theme.of(context).textTheme.bodySmall,)
               ],
        ),
    );
  }
}
