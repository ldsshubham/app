import 'package:flutter/material.dart';

class AdminAddProducts extends StatelessWidget {
  const AdminAddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Product Name"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: "Product Description"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: "Product Category"),
                ),
                SizedBox(height: 8),
                TextFormField(decoration: InputDecoration(labelText: "Price")),
                SizedBox(height: 8),
                TextFormField(decoration: InputDecoration(labelText: "Unit")),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
