import 'package:app/app/admin/utils/product_card.dart';
import 'package:flutter/material.dart';

class AdminProductsListPage extends StatelessWidget {
  const AdminProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Products'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),

          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 230,
            ),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ProductCard(
                imageUrl:
                    'https://www.venkateshwaragroup.in/vgiblog/wp-content/uploads/2023/04/Scope-for-Agriculture.jpg',
                title: "Product",
                category: "cat",
                price: '10',
                onTap: () {},
                onDelete: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
