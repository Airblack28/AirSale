import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: width,
                child: TextField(
                  // controller: searchController.value,
                  // onChanged: (value) => searchController.notifyListeners(),
                  decoration: InputDecoration(
                    hintText: "Research Products or Brands",
                    prefixIcon: Icon(Icons.search)),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}