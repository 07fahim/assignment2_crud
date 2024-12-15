

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteFunction {
  static Future<bool> deleteProduct(String id, BuildContext context) async {
    final uri = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
    final response = await http.get(uri);
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && decodedResponse['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to delete product'),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }

  static Future<void> showDeleteConfirmation(BuildContext context, String id, VoidCallback onDeleteSuccess) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure? Will you delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final success = await deleteProduct(id, context);
                if (success) {
                  onDeleteSuccess();
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }
}