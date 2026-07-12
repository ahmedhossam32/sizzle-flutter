import 'package:flutter/material.dart';

class mainScrollPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Beef', 'image': 'assets/beef.png'},
    {'name': 'Chicken', 'image': 'assets/chicken.png'},
    {'name': 'Dessert', 'image': 'assets/dessert.png'},
    {'name': 'Lamb', 'image': 'assets/lamb.png'},
  ];

  mainScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Categories",
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF2A1408)
            ),
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
            }
        ),
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30.0), // Rounded pill shape
    border: Border.all(
    color: const Color(0xFFF3E5DB), // Light beige border
    width: 1.5,
    ),
    ),
    ),
    ]
    );

  }
}