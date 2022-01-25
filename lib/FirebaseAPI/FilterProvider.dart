import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class FilterProvider extends ChangeNotifier {
  static FilterProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<FilterProvider>(context, listen: listen);

  List<Product> _filteredProducts = [];

  List<Product> get filteredProducts => _filteredProducts;
  List<Product> _products = [];
  List<Product> get products => _products;
  List<String> _selectedCategory = [];
  List<String> get selectedCategory => _selectedCategory;
  List<Category> _initialCategories = [];
  List<Category> get initialCategories => _initialCategories;
  List<Size> _initialSizes = [];
  List<Size> get initialSizes => _initialSizes;
  List<Brand> _initialBrands = [];
  List<Brand> get initialBrands => _initialBrands;
  List<PriceRange> _initialPriceRanges = [];
  List<PriceRange> get initialPriceRanges => _initialPriceRanges;
  Category parentCategory;
  List<Brand> _selectedBrands = [];
  List<Brand> get selectedBrands => _selectedBrands;
  List<String> _color = [];
  List<String> get color => _color;
  List<Size> _sizes = [];
  List<Size> get sizes => _sizes;
  List<PriceRange> _selectedPriceRanges = [];
  List<PriceRange> get selectedPriceRanges => _selectedPriceRanges;
  List<String> _newArrivals = [];
  List<String> get newArrivals => _newArrivals;
  bool _discountsOnly;

  static final CategoryRef = FirebaseFirestore.instance
      .collection('categories')
      .withConverter<Category>(
        fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()),
        toFirestore: (category, _) => category.toJson(),
      );
  static final ProductRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
            toFirestore: (product, _) => product.toJson(),
          );
  static final BrandRef =
      FirebaseFirestore.instance.collection('brands').withConverter<Brand>(
            fromFirestore: (snapshot, _) => Brand.fromJson(snapshot.data()),
            toFirestore: (brand, _) => brand.toJson(),
          );
  static final SizeRef =
      FirebaseFirestore.instance.collection('sizes').withConverter<Size>(
            fromFirestore: (snapshot, _) => Size.fromJson(snapshot.data()),
            toFirestore: (size, _) => size.toJson(),
          );
  static final PriceRangeRef = FirebaseFirestore.instance
      .collection('price ranges')
      .withConverter<PriceRange>(
        fromFirestore: (snapshot, _) => PriceRange.fromJson(snapshot.data()),
        toFirestore: (range, _) => range.toJson(),
      );

  Future<void> setProducts() async {
    _products = await ProductRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    _filteredProducts.clear();
    _filteredProducts = []..addAll(_products);
    notifyListeners();
  }

  Future<void> setCategories() async {
    _initialCategories = await CategoryRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  Future<void> setPriceRanges() async {
    _initialPriceRanges = await PriceRangeRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  Future<void> setSizes() async {
    _initialSizes = await SizeRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  Future<void> setBrands() async {
    _initialBrands = await BrandRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  // Category getParentCategory(Product product) {
  //   List<String> names = product.categories.map((e) => e.name).toList();
  //   for (String name in names) {
  //     return searchLoop(name, _initialCategories);
  //   }
  //   return null;
  // }
  //
  // Category searchLoop(String categoryName, List<Category> categories) {
  //   for (Category category in categories) {
  //     if (category.level == -1) {
  //       parentCategory = category;
  //     }
  //     if (category.name == categoryName) {
  //       return parentCategory;
  //     } else {
  //       if (!category.subCategories.isEmpty) {
  //         return searchLoop(categoryName, category.subCategories);
  //       }
  //     }
  //   }
  //   return null;
  // }

  void updateBrands(List<Brand> brand) {
    _selectedBrands?.clear();
    brand.forEach((element) {
      _selectedBrands?.add(element);
    });
    updateFilteredProducts();
    notifyListeners();
  }

  void updateCategories(List<String> category) {
    _selectedCategory?.clear();
    category.forEach((element) {
      _selectedCategory?.add(element);
    });
    updateFilteredProducts();
    notifyListeners();
  }

  void updateSizes(List<Size> sizes) {
    _sizes?.clear();
    sizes.forEach((element) {
      _sizes?.add(element);
    });
    updateFilteredProducts();
    notifyListeners();
  }

  void updatePrices(List<PriceRange> prices) {
    _selectedPriceRanges?.clear();
    prices.forEach((element) {
      _selectedPriceRanges?.add(element);
    });
    updateFilteredProducts();
    notifyListeners();
  }

  void updateColor(List<String> color) {
    _color.clear();
    color.forEach((element) {
      _color.add(element);
    });
    updateFilteredProducts();
    notifyListeners();
  }

  void updateFilteredProducts() {
    if (_selectedCategory != null && _selectedCategory.length != 0) {
      _filteredProducts = _products.where((element) {
        var productCategory = element.categories;
        var selectedCategory = _selectedCategory;

        var firstListSet = productCategory.toSet();
        var secondListSet = selectedCategory.toSet();
        return firstListSet.intersection(secondListSet).length ==
            selectedCategory.length;
      }).toList();
    } else {
      _filteredProducts.clear();
      _filteredProducts..addAll(_products);
    }
    if (_selectedBrands != null && _selectedBrands.length != 0) {
      _filteredProducts = _filteredProducts.where((product) {
        return _selectedBrands.map((e) => e.name).contains(product.brand.name);
      }).toList();
    }
    if (_sizes != null && _sizes.length != 0) {
      _filteredProducts = _filteredProducts.where((product) {
        return _sizes.map((e) => e.name).contains(product.size.name);
      }).toList();
    }
    if (_selectedPriceRanges != null && _selectedPriceRanges.length != 0) {
      _filteredProducts = _filteredProducts
          .where((first) => _selectedPriceRanges.any((element) {
                if (element.max != null) {
                  return first.price >= element.min &&
                      first.price <= element.max;
                }
                return first.price >= element.min;
              }))
          .toList();
    }
    // .where((element) => element.productId == "kYzWt1d8QFt5nxQBck3x")
    // .where((element) => element.productId == "kYzWt1d8QFt5nxQBck3x")
    notifyListeners();
  }

  void clearSelected() {
    sizes.clear();
    selectedBrands.clear();
    selectedPriceRanges.clear();
    selectedCategory.clear();
    initialSizes.forEach((element) {
      element.isSelected = false;
    });
    initialBrands.forEach((element) {
      element.isSelected = false;
    });
    initialPriceRanges.forEach((element) {
      element.isSelected = false;
    });
    initialCategories.forEach((element) {
      element.isSelected = false;
    });

    updateFilteredProducts();
    notifyListeners();
  }
}
