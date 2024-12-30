import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test/api/product_controller.dart';
import 'package:test/screen/product_detail.dart';

class Dashbord extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  void logout() {
    final box = GetStorage();
    box.erase(); // Clear all stored data
    Get.offNamed('/login'); // Redirect to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              // Add your logout logic here
              Get.offAllNamed('/login'); // Example: Navigate to the login page
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black, // Optional: Set icon color
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailsView(
                              title: product.title,
                              image: product.image,
                              price: product.price,
                              description: product.description,
                            ));
                      },
                      child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  color: Colors.grey[200],
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "\$${product.price}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  // Handle favorite action
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
