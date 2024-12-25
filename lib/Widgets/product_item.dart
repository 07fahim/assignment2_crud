import 'package:assignment2_crud/UI/Screen/Update_product_Screen.dart';
import 'package:assignment2_crud/UI/Style/style.dart';
import 'package:assignment2_crud/utils/delete_function.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment2_crud/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onRefresh,
    required this.isDarkMode,
  });

  final Product product;
  final Function() onRefresh;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkMode ? darkCardColor : Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.network(
              product.image ?? 'Unknown',
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                size: 60,
                color: isDarkMode ? darkIconColor : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName ?? 'Unknown',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? darkTextColor : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Product Code: ${product.productCode ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? darkIconColor : Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Quantity: ${product.quantity ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? darkIconColor : Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Price: ${product.unitPrice ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? darkIconColor : Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Total Price: ${product.totalPrice ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? darkIconColor : Colors.deepOrangeAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      DeleteFunction.showDeleteConfirmation(
                        context: context,
                        id: product.id ?? '',
                        productName: product.productName ?? 'Unknown',
                        productCode: product.productCode ?? 'Unknown',
                        quantity: product.quantity?.toString() ?? 'Unknown',
                        price: product.unitPrice?.toString() ?? 'Unknown',
                        totalPrice: product.totalPrice?.toString() ?? 'Unknown',
                        imageUrl: product.image,
                        onDeleteSuccess: onRefresh,
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: isDarkMode ? darkTextColor : Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDarkMode ? darkCardColor : Colors.lightBlueAccent,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      final dynamic result = await Navigator.pushNamed(
                        context,
                        UpdateProductScreen.name,
                        arguments: product,
                      );
                      if (result is bool && result) {
                        onRefresh();
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      color: isDarkMode ? darkTextColor : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}