import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/button_header.dart';

class DetailHeader extends StatelessWidget{
      const DetailHeader({super.key});
     @override
  Widget build(BuildContext context){
       return Stack(
         children: [
           Positioned(child: ButtonHeader(onClickedBack: () => context.pop(),))
         ],
       );
     }
}