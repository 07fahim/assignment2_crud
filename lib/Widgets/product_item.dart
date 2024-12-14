import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? '',
        width: 40,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 40),
      ),
      title: Text(product.productName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? 'Unknown'}'),
          Text('Quantity: ${product.quantity ?? 'Unknown'}'),
          Text('Price: ${product.unitPrice ?? 'Unknown'}'),
          Text('Total Price: ${product.totalPrice ?? 'Unknown'}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration:  const BoxDecoration(
              color: colorGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // TODO: implement delete product api
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: colorBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // TODO: implement edit functionality
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}