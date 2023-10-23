import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      // borderSide: BorderSide(
                      //   style: BorderStyle.solid,
                      // ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    hintText: "Search",
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            const Icon(
                Icons.notifications,
                size: 35,color: Color.fromARGB(255, 16, 98, 92)
            ),
          ],
        )
    );
  }
}
