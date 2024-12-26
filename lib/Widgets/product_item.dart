import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment2_crud/models/product.dart';
import 'package:assignment2_crud/utils/delete_function.dart';
import 'package:assignment2_crud/UI/Screen/Update_product_Screen.dart';

import '../UI/Style/style.dart';

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

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 4,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkMode ? darkCardColor : Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (product.image != null) {
                  _showFullScreenImage(context, product.image!);
                }
              },
              child: Image.network(
                product.image ?? 'Unknown',
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: isDarkMode ? darkIconColor : Colors.grey,
                ),
              ),
            ),
            // Rest of your existing widget code remains the same
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

                    ),
                  ),
                  Text(
                    'Quantity: ${product.quantity ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? darkIconColor : Colors.grey,

                    ),
                  ),
                  Text(
                    'Price: Tk ${product.unitPrice ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? darkIconColor : Colors.grey,

                    ),
                  ),
                  Text(
                    'Total Price: Tk ${product.totalPrice ?? 'Unknown'}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.blueGrey : Colors.deepOrangeAccent,

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
                    color: isDarkMode ? Colors.blueGrey : Colors.lightBlueAccent,
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