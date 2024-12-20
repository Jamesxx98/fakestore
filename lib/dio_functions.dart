import 'package:dio/dio.dart';


Dio dio = Dio(
    options
);
final options = BaseOptions(
    baseUrl: "https://fakestoreapi.com/products",
    connectTimeout: Duration(seconds: 30)
);
Future<List<dynamic>> getProducts() async{
  try{
    var response = await dio.get("");
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
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