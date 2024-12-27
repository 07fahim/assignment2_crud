import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DeleteFunction {
  static Future<bool> deleteProduct(String id) async {
    final uri = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
    try {
      final response = await http.get(uri);
      return response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  static void showDeleteConfirmation({
    required BuildContext context,
    required String id,
    required String productName,
    required String productCode,
    required String quantity,
    required String price,
    required String totalPrice,
    required String? imageUrl,
    required Function() onDeleteSuccess,
    required bool isDarkMode,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          title: Text(
            'Delete Product',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you sure you want to delete this product?',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (imageUrl != null)
                    Center(
                      child: Image.network(
                        imageUrl,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: isDarkMode ? Colors.grey : Colors.black38,
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      productName,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.lightBlueAccent : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Product Code: $productCode',
                      style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Quantity: $quantity',
                      style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Price: $price',
                      style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Total Price: $totalPrice',
                      style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[300] : Colors.black87,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.red.shade700 : Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
              onPressed: () async {
                final success = await deleteProduct(id);
                if (success) {
                  onDeleteSuccess();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to delete product',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white,
                        ),
                      ),
                      backgroundColor: isDarkMode ? Colors.red.shade700 : Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.white,
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.all(16),
        );
      },
    );
  }
}