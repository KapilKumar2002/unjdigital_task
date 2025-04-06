import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const SearchBox({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Material(
        elevation: 8, // Increased elevation for a floating effect
        shadowColor: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          onChanged: onSearchChanged,
          controller: searchController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            hintText: "Search by name or email",
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.blueAccent),
                    onPressed: () {
                      searchController.clear();
                      onSearchChanged('');
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.blue[50], // Subtle hover effect
          ),
        ),
      ),
    );
  }
}
