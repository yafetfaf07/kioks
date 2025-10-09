import 'package:flutter/material.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: 100,

        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(width: 10, color: Colors.green.shade100),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.green.shade100,
              ),
              child: Image.asset(
                'assets/categoriesimage/vegetables.png',
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Text('Category'),
          ],
        ),
      ),
    );
  }
}
