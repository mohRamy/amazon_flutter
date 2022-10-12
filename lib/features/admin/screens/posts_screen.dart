import 'package:amazon_flutter/common/widgets/loader.dart';
import 'package:amazon_flutter/features/account/widgets/single_product.dart';
import 'package:amazon_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_flutter/routes.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  // List<Product>? products;
  // final AdminServices adminServices = AdminServices();

  // @override
  // void initState() {
  //   super.initState();
  //   fetchAllProducts();
  // }

  // fetchAllProducts() async {
  //   products = await adminServices.fetchAllProducts(context);
  //   setState(() {});
  // }

  // void deleteProduct(Product product, int index) {
  //   adminServices.deleteProduct(
  //     context: context,
  //     product: product,
  //     onSuccess: () {
  //       products!.removeAt(index);
  //       setState(() {});
  //     },
  //   );
  // }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, Routers.addProductScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 4,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          // final productData = products![index];
          return Column(
            children: [
              // SizedBox(
              //   height: 140,
              //   child: SingleProduct(
              //     image: productData.images[0],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'productData.name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
