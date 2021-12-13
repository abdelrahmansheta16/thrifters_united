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
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  List<Brand> _brands = [];
  List<Brand> get brands => _brands;
  List<String> _color;
  List<String> get color => _color;
  List<String> _sizes = [];
  List<String> get sizes => _sizes;
  List<List<int>> _prices = [];
  List<List<int>> get prices => _prices;
  List<String> _newArrivals = [];
  List<String> get newArrivals => _newArrivals;
  bool _discountsOnly;
  void setProducts(List<Product> products) {
    _products.clear();
    products.forEach((element) {
      _products.add(element);
    });
    _filteredProducts.clear();
    products.forEach((element) {
      _filteredProducts.add(element);
    });
    notifyListeners();
  }

  void updateBrands(List<Brand> brands) {
    _brands?.clear();
    brands.forEach((element) {
      _brands?.add(element);
    });
    notifyListeners();
  }

  void updateCategories(List<Category> categories) {
    _categories?.clear();
    categories.forEach((element) {
      _categories?.add(element);
    });
    notifyListeners();
  }

  void updateSizes(List<String> sizes) {
    _sizes?.clear();
    sizes.forEach((element) {
      _sizes?.add(element);
    });
    notifyListeners();
  }

  void updatePrices(List<List<int>> prices) {
    _prices?.clear();
    prices.forEach((element) {
      _prices?.add(element);
    });
    notifyListeners();
  }

  void updateColor(List<String> color) {
    _color.clear();
    color.forEach((element) {
      _color.add(element);
    });
    notifyListeners();
  }

  void updateFilteredProducts() {
    if (_categories != null && _categories.length != 0) {
      List<String> names = _categories.map((e) => e.name).toList();
      _filteredProducts = _products.where((element) {
        return element.categories
            .any((element) => names.contains(element.name));
      }).toList();
    }
    if (_brands != null && _brands.length != 0) {
      _filteredProducts = _filteredProducts
          .where((first) => _brands.any((element) => element == first.brand))
          .toList();
    }
    if (_sizes != null && _sizes.length != 0) {
      _filteredProducts = _filteredProducts
          .where((element) =>
              element.size.any((element) => _sizes.contains(element)))
          .toList();
    }
    if (_prices != null && _prices.length != 0) {
      _filteredProducts = _filteredProducts
          .where((first) =>
              _prices.any((element) => element.contains(first.price)))
          .toList();
    }
    // .where((element) => element.productId == "kYzWt1d8QFt5nxQBck3x")
    // .where((element) => element.productId == "kYzWt1d8QFt5nxQBck3x")
    notifyListeners();
  }
}
