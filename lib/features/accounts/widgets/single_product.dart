import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({super.key, this.image = "https://unsplash.com/photos/a-person-holding-an-iphone-in-their-hand-fw_KhcwHmlY"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black12,
              width: 1.5,
            )),
        width: 180,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.network(
            image,
          ),
        ),
      ),
    );
  }
}
