import '../cart_ctrl/cart_ctrl.dart';
import '../../../models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/user_ctrl.dart';

// class CartProduct extends GetView<CartCtrl> {
//   final int index;
//     const CartProduct({
//     Key? key,
//     required this.index,
//   }) : super(key: key);

  

//   @override
//   Widget build(BuildContext context) {
//     final productCart = Get.find<UserCtrl>().user.cart[index];
//     final product = ProductModel.fromMap(productCart['product']);

//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(
//             horizontal: 10,
//           ),
//           child: Row(
//             children: [
//               Image.network(
//                 product.images[0],
//                 fit: BoxFit.contain,
//                 height: 135,
//                 width: 135,
//               ),
//               Column(
//                 children: [
//                   Container(
//                     width: 235,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       product.name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                       ),
//                       maxLines: 2,
//                     ),
//                   ),
//                   Container(
//                     width: 235,
//                     padding: const EdgeInsets.only(left: 10, top: 5),
//                     child: Text(
//                       '\$${product.price.toInt()}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 2,
//                     ),
//                   ),
//                   Container(
//                     width: 235,
//                     padding: const EdgeInsets.only(left: 10),
//                     child: const Text('Eligible for FREE Shipping'),
//                   ),
//                   Container(
//                     width: 235,
//                     padding: const EdgeInsets.only(left: 10, top: 5),
//                     child: const Text(
//                       'In Stock',
//                       style: TextStyle(
//                         color: Colors.teal,
//                       ),
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.all(10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black12,
//                     width: 1.5,
//                   ),
//                   borderRadius: BorderRadius.circular(5),
//                   color: Colors.black12,
//                 ),
//                 child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           width: 35,
//                           height: 32,
//                           alignment: Alignment.center,
//                           child: const Icon(
//                             Icons.remove,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                       DecoratedBox(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black12, width: 1.5),
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(0),
//                           ),
//                           child: Container(
//                             width: 35,
//                             height: 32,
//                             alignment: Alignment.center,
//                             child: GetBuilder<CartCtrl>(
//                               builder: (controller) =>  Text(
//                                 productCart['quantity'].toString(),
//                               ),
//                             ),
//                           ),
//                         ),
                      
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           width: 35,
//                           height: 32,
//                           alignment: Alignment.center,
//                           child: const Icon(
//                             Icons.add,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
              
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
