import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final options = BaseOptions(
    baseUrl: "https://fakestoreapi.com/products",// The base URL for all API requests.
    connectTimeout: Duration(seconds: 30) // Timeout duration for connecting to the server.
);

// Initializing a Dio instance with predefined options.
Dio dio = Dio(
    options
);

// Function to fetch a list of products from the API.
Future<List<dynamic>> getProducts() async{
  try{
    var response = await dio.get("");
    if(response.statusCode==200){
      return response.data;  // Returning the list of products if the server responded with a status code of 200 (OK)
    }else{
      throw Exception('Failed to fetch products. Status code: ${response.statusCode}'); // Throwing an exception if the response status is not OK.
    }
  }catch(e){
    if(e is DioException){
      print(e.message);
    }
    rethrow;
  }
}

Future<dynamic> getProductById(String id) async{
  print("this is id  $id");
  try{
    var response = await dio.get("/$id");
    if(response.statusCode ==200){
      return response.data;
    }else{
      throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
    }
  }catch(e){
    print("error from getProductById $e");
    if(e is DioException){
      print(e.message);
    }
    rethrow;
  }
}
class ApiCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Store API Products"),
      ),
      body: FutureBuilder<List>(
        future: getProducts(),
        builder: (context, snapshot) {
          // While loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // If error occurs
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If data is successfully fetched
          else if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(
                    product['image'],
                    width: 50,
                    height: 80,

                  ),
                  title: Text(product['title']),
                  subtitle: Text('\$${product['price']}'),
                );
              },
            );
          }
          else {
            return Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}