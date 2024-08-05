import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: GlobalVariables.greyBackgroundCOlor, width: 0),
          borderRadius: BorderRadius.circular(50),
          color: GlobalVariables.greyBackgroundCOlor,
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            overlayColor: const Color.fromARGB(255, 150, 150, 150),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            )
          ),
          onPressed: onTap, child: Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),)
          ),
      ),
    );
  }
}
