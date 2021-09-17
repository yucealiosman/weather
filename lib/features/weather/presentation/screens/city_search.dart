import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Form(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                child: _CityInputField())
          ],
        ),
      ),
    );
  }
}

class _CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => Navigator.pop(context, value),
      decoration: InputDecoration(
        labelText: 'Enter a city',
        hintText: 'Example: Chicago',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}

