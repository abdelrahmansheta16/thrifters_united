import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/constants.dart';

class BrandsList extends StatefulWidget {
  final List<Brand> brands;
  final List<PriceRange> range;
  final List<Size> size;
  BrandsList({Key key, this.brands, this.range, this.size}) : super(key: key);

  @override
  _BrandsListState createState() => _BrandsListState();
}

class _BrandsListState extends State<BrandsList> {
  List<Brand> selectedBrands = [];
  List<Size> selectedSizes = [];
  List<PriceRange> selectedRanges = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: List.generate(
                  widget.brands != null
                      ? widget.brands.length
                      : widget.size != null
                          ? widget.size.length
                          : widget.range.length, (index) {
                Brand currentBrand =
                    widget.brands != null ? widget.brands[index] : null;
                PriceRange priceRange =
                    widget.range != null ? widget.range[index] : null;
                Size size = widget.size != null ? widget.size[index] : null;
                return Material(
                  child: ListTile(
                    selected: currentBrand?.isSelected ??
                        priceRange?.isSelected ??
                        size?.isSelected,
                    onTap: () {
                      setState(() {
                        if (currentBrand?.isSelected ??
                            priceRange?.isSelected ??
                            size?.isSelected) {
                          widget.brands != null
                              ? currentBrand.isSelected = false
                              : widget.size != null
                                  ? size.isSelected = false
                                  : priceRange.isSelected = false;
                        } else {
                          widget.brands != null
                              ? currentBrand.isSelected = true
                              : widget.size != null
                                  ? size.isSelected = true
                                  : priceRange.isSelected = true;
                        }
                        updateSelected('brands');
                      });
                    },
                    title: Text(
                      widget.brands != null
                          ? currentBrand.name
                          : widget.size != null
                              ? size.name
                              : priceRange.max != null
                                  ? '${priceRange.min.toString()} EGP - ${priceRange.max.toString()} EGP'
                                  : 'Above ${priceRange.min} EGP',
                      style: TextStyle(
                        color: currentBrand?.isSelected ??
                                priceRange?.isSelected ??
                                size?.isSelected
                            ? Color(0xFF1D9E6A)
                            : Colors.black,
                      ),
                    ),
                    trailing: currentBrand?.isSelected ??
                            priceRange?.isSelected ??
                            size?.isSelected
                        ? Icon(
                            Icons.check_sharp,
                            color: Color(0xFF1D9E6A),
                          )
                        : Icon(Icons.keyboard_arrow_right_sharp),
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: selectedBrands.length != 0 ||
                        selectedSizes.length != 0 ||
                        selectedRanges.length != 0
                    ? () {
                        widget.brands != null
                            ? FilterProvider.of(context, listen: false)
                                .updateBrands(selectedBrands)
                            : widget.size != null
                                ? FilterProvider.of(context, listen: false)
                                    .updateSizes(selectedSizes)
                                : FilterProvider.of(context, listen: false)
                                    .updatePrices(selectedRanges);
                        Navigator.pop(context);
                      }
                    : null,
                child: Text(selectedBrands.length != 0 ||
                        selectedSizes.length != 0 ||
                        selectedRanges.length != 0
                    ? 'selected ${selectedBrands.length != 0 ? selectedBrands.length : selectedSizes.length != 0 ? selectedSizes.length : selectedRanges.length} ${selectedBrands.length != 0 ? 'brands' : selectedSizes.length != 0 ? 'sizes' : selectedRanges.length != 0 ? 'price ranges' : ''}'
                    : 'choose'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateSelected(String filterName) {
    switch (filterName) {
      case 'brands':
        selectedBrands.clear();
        widget.brands?.forEach((element) {
          if (element.isSelected) {
            selectedBrands.add(element);
          }
        });
        setState(() {});
        continue sizes;
      sizes:
      case 'sizes':
        selectedSizes.clear();
        widget.size?.forEach((element) {
          if (element.isSelected) {
            selectedSizes.add(element);
          }
        });
        setState(() {});
        continue ranges;
      ranges:
      case 'ranges':
        selectedRanges.clear();
        widget.range?.forEach((element) {
          if (element.isSelected) {
            selectedRanges.add(element);
          }
        });
        setState(() {});
        break;
      default:
        null;
    }
  }
}
