import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                Expanded(
                    child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(),
                )),
                IconButton(onPressed: () {}, icon: Icon(Icons.downhill_skiing)),
              ],
            ),
            const Text('data')
          ],
        ),
      ),
    );
  }
}
