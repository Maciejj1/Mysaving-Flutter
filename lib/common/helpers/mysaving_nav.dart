import 'package:flutter/material.dart';

import '../utils/mysaving_images.dart';

// ignore: must_be_immutable
class MySavingUpNav extends StatelessWidget {
  MySavingUpNav({super.key});
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                    width: 50,
                    child: Image.asset(images.defaultProfilePicture)),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Text('Dzień dobry'),
                      Text('Maciej'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
    );
  }
}
