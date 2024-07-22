import 'package:flutter/material.dart';


class MyPostButton extends StatelessWidget {
  final void Function()? onTap;
   const MyPostButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(14)
        ),
        child:  Center(
          child:  Icon(Icons.done,color: Theme.of(context).colorScheme.primary,),
        ),
      ),
    );
  }
}
