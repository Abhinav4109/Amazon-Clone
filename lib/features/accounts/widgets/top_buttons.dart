import 'package:amazon_clone/features/accounts/services/account_services.dart';
import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              AccountButton(
                text: 'Your Orders',
                onTap: () {},
              ),
              const SizedBox(
                width: 15,
              ),
              AccountButton(
                text: 'Turn Seller',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              AccountButton(
                text: 'Log Out',
                onTap: () => AccountServices().logOut(context),
              ),
              const SizedBox(
                width: 15,
              ),
              AccountButton(
                text: 'Your Wish List',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
