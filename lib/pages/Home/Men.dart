import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/FirebaseAPI/ProductAPI.dart';
import 'package:thrifters_united/customUi/CategoryWidget.dart';
import 'package:thrifters_united/customUi/ProductContainer.dart';
import 'package:thrifters_united/customUi/ProductsGridView.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class Men extends StatefulWidget {
  const Men({Key key}) : super(key: key);

  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {
  List<Product> products = [];
  List<Category> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                childAspectRatio: 0.9,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                CategoryWidget(
                  label: 'Clothing',
                  imageUrl:
                      'https://i.pinimg.com/originals/84/48/af/8448af80944eaca909874361f6009221.png',
                ),
                CategoryWidget(
                  label: 'Sportswear',
                  imageUrl:
                      'https://static.toiimg.com/thumb/msid-71614991,width-1200,height-900,resizemode-4/.jpg',
                ),
                CategoryWidget(
                  label: 'Grooming',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbg9Z1eSNRn25I4JC4muRwJf5m2hUBm2O9FQ&usqp=CAU',
                ),
                CategoryWidget(
                  label: 'Homeware',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk0bQYA0rOoEOz2huiYHneBlvdAgYQ5LvI7A&usqp=CAU',
                ),
                CategoryWidget(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3o3H143Vgkfz6nBKJWnxYbuReFq87lj7W3g&usqp=CAU',
                  label: 'Thrifters',
                ),
                CategoryWidget(
                  label: 'Bags',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwrV_neQ26i4AgcbeqHFzifRyzBVwb50Sa9Q&usqp=CAU',
                ),
                CategoryWidget(
                  label: 'Shoes',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrE_8L_ueAvoqoaH1LsdbSbyjBSMT5RSVXEQ&usqp=CAU',
                ),
                CategoryWidget(
                  label: 'Accessories',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWp08M8eBREbrMszik4eudJlyUSgpcv5FKNQ&usqp=CAU',
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<Product>>(
            stream: ProductAPI.loadProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<Product> products =
                  snapshot.data.docs.map((DocumentSnapshot document) {
                Product product;
                product = document.data();
                return product;
              }).toList();
              // Wait for the widget to build before calling this function
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                FilterProvider.of(context, listen: false).setProducts(products);
              });
              // List<String> names = [
              //   "Casual Dresses",
              //   "Mini Dresses",
              //   "Maxi Dresses",
              //   "Sunglasses",
              // ];
              // products = products
              //     .where((element) {
              //       return element.categories
              //           .any((element) => names.contains(element.name));
              //     })
              //     .where(
              //         (element) => element.productId == "kYzWt1d8QFt5nxQBck3x")
              //     .toList();
              // products.clear();
              // selectedCategories.clear();
              // getProducts(women, names);
              // print(products);
              // var clearProducts = products.toSet().toList();
              // print(clearProducts);
              return ProductsGridView();
            },
          ),
        ],
      ),
    );
  }

  // void getProducts(Category category, List<String> names) {
  //   if (names.contains(category.name)) {
  //     String name =
  //         names.where((element) => names.contains(category.name)).toString();
  //     selectedCategories.add(category);
  //   }
  //   category.subCategories.forEach((first) {
  //     if (names.contains(first.name)) {
  //       selectedCategories.add(first);
  //     }
  //     if (first.subCategories.length != 0) {
  //       first.subCategories.forEach((element) {
  //         getProducts(element, names);
  //       });
  //     }
  //   });
  //
  //   selectedCategories.toSet().toList();
  //   selectedCategories.forEach((first) {
  //     print(first.name);
  //     first.products.forEach((second) {
  //       products.add(second);
  //     });
  //   });
  // }
}
