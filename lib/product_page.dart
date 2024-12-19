// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dio_functions.dart';
//
// class ProductsPage extends GetView {
//   var args = Get.arguments;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor:Colors.cyan ,
//       appBar: AppBar(
//         title: const Text("Products"),
//       ),
//       body: FutureBuilder(
//           future: getProducts(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasData) {
//               return ListView(
//                 children: [
//                   for (var i in snapshot.data)
//                     ListTile(
//                       leading: Text(i['id'].toString()),
//                       title: Text(i['title']),
//                       subtitle: Text(
//                         i['description'],
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       trailing: SizedBox(
//                         width: 30,
//                         child: Image.network(
//                           i['image'],
//                           fit: BoxFit.contain,
//
//                         ),
//                       ),
//                     )
//                 ],
//               );
//             }
//             return const Center(
//               child: Text("No data found"),
//             );
//           }),
//     );
//   }
//
//   getProducts() {}
// }