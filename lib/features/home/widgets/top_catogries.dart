import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/catogery_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCatogries extends StatelessWidget {
  const TopCatogries({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CatogeryDealsScreen.routeName, arguments: GlobalVariables.categoryImages[index]['title']!);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      GlobalVariables.categoryImages[index]['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
