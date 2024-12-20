import 'package:flutter/material.dart';
import 'dio_functions.dart';


class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<dynamic>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.map((product) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        product['image'] != null
                            ? Image.network(
                          product['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : const Icon(Icons.image_not_supported, size: 50),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product['title'] ?? 'No Title',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('\$${product['price'] ?? 'N/A'}',
                                  style: const TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final details = await getProductById(product['id'].toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(product: details),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                          ),
                          child: const Text('View Details'),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final dynamic product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title'] ?? 'Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product['title'] ?? 'No Title', style: const TextStyle(fontSize: 24)),
            Text('\$${product['price'] ?? 'N/A'}', style: const TextStyle(color: Colors.green)),
            const SizedBox(height: 16),
            Text(product['description'] ?? 'No Description'),
          ],
        ),
      ),
    );
  }
}