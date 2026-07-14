import 'package:flutter/material.dart';
import 'package:sizzle_flutter/designTokens/design_tokens.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: DesignTokens.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sizzle",
                style: TextStyle(color: DesignTokens.cream, fontSize: 32),
              ),
              Text(
                "What's cooking today?",
                style: TextStyle(color: DesignTokens.cream, fontSize: 16),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search meals, e.g. arrabiata...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: DesignTokens.deepOrange,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (i){
            setState(() {
              index=i;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.dining_sharp,shadows: [
              Shadow(color: DesignTokens.deepOrange)
            ],), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Saved"),
          ],
          selectedItemColor: DesignTokens.deepOrange,
        ),
        body: Center(),
      ),
    );
  }
}
