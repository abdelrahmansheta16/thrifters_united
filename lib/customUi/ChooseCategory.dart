import 'package:flutter/material.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class ChooseCategory extends StatefulWidget {
  final Category category;
  const ChooseCategory({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  State<ChooseCategory> createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  Category selectedCategory;
  List<String> selectedPath = [];
  @override
  void initState() {
    selectedPath.insert(widget.category.level + 1, widget.category.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Category currentCategory = widget.category.subCategories[index];
        return buildExpansionTile(currentCategory);
      },
      separatorBuilder: (context, index) => Container(
        color: Colors.white60,
        height: 1,
        width: MediaQuery.of(context).size.width,
      ),
      itemCount: widget.category.subCategories.length,
    );
  }

  Widget buildExpansionTile(Category currentCategory) {
    if (currentCategory.subCategories.length == 0) {
      return ListTile(
        selected: currentCategory == selectedCategory,
        onTap: () {
          setState(() {
            // updateSelected(widget.category);
            // selectedCategory.isSelected = false;
            selectedCategory = currentCategory;
            // currentCategory.isSelected = !currentCategory.isSelected;
            // if (currentCategory.isSelected) {
            if (selectedPath.length > currentCategory.level + 1) {
              selectedPath.removeAt(currentCategory.level + 1);
            }
            selectedPath.insert(
                currentCategory.level + 1, currentCategory.name);
            // }
            print(selectedPath);
          });
          FilterProvider.of(context, listen: false)
              .updateCategories(selectedPath);
          // getSelectedCategories();
        },
        title: Padding(
          padding: EdgeInsets.only(left: getPadding(currentCategory.level)),
          child: Text(
            currentCategory.name,
            style: getStyle(
                currentCategory.level, currentCategory == selectedCategory),
          ),
        ),
        trailing: currentCategory == selectedCategory
            ? Icon(
                Icons.check_sharp,
                color: Color(0xFF1D9E6A),
              )
            : Icon(Icons.keyboard_arrow_right_sharp),
      );
    }
    return ExpansionTile(
      title: Padding(
        padding: EdgeInsets.only(left: getPadding(currentCategory.level)),
        child: Text(
          currentCategory.name,
          style: getStyle(
              currentCategory.level, currentCategory == selectedCategory),
        ),
      ),
      trailing: currentCategory.subCategories.length == 0
          ? Icon(Icons.keyboard_arrow_right_sharp)
          : currentCategory.isExpanded
              ? Icon(Icons.keyboard_arrow_up_sharp)
              : Icon(Icons.keyboard_arrow_down_sharp),
      children: List.generate(currentCategory.subCategories.length, (index) {
        if (index == 0) {
          return ListTile(
            selected: currentCategory == selectedCategory,
            onTap: () {
              setState(() {
                // updateSelected(widget.category);
                // subCategory.isSelected = !subCategory.isSelected;
                selectedCategory = currentCategory;
                // if (subCategory.isSelected) {
                if (selectedPath.length > currentCategory.level + 1) {
                  selectedPath.removeAt(currentCategory.level + 1);
                }
                selectedPath.insert(
                    currentCategory.level + 1, currentCategory.name);
                // }
                if (selectedPath.length > currentCategory.level + 2) {
                  selectedPath.removeRange(
                      currentCategory.level + 2, selectedPath.length);
                }
                print(selectedPath);
              });
              FilterProvider.of(context, listen: false)
                  .updateCategories(selectedPath);
              // getSelectedCategories();
            },
            title: Padding(
              padding:
                  EdgeInsets.only(left: getPadding(currentCategory.level + 1)),
              child: Text(
                'All ${currentCategory.name}',
                style: getStyle(currentCategory.level + 1,
                    currentCategory == selectedCategory),
              ),
            ),
            trailing: currentCategory == selectedCategory
                ? Icon(
                    Icons.check_sharp,
                    color: Color(0xFF1D9E6A),
                  )
                : Icon(Icons.keyboard_arrow_right_sharp),
          );
        }
        Category subCategory = currentCategory.subCategories[index - 1];
        if (subCategory.subCategories.length == 0) {
          return ListTile(
            selected: subCategory == selectedCategory,
            onTap: () {
              setState(() {
                // updateSelected(widget.category);
                // subCategory.isSelected = !subCategory.isSelected;
                selectedCategory = subCategory;
                // if (subCategory.isSelected) {
                if (selectedPath.length > subCategory.level + 1) {
                  selectedPath.removeAt(subCategory.level + 1);
                }
                selectedPath.insert(subCategory.level + 1, subCategory.name);
                // }
                print(selectedPath);
              });
              FilterProvider.of(context, listen: false)
                  .updateCategories(selectedPath);
              // getSelectedCategories();
            },
            title: Padding(
              padding: EdgeInsets.only(left: getPadding(subCategory.level)),
              child: Text(
                subCategory.name,
                style: getStyle(
                    subCategory.level, subCategory == selectedCategory),
              ),
            ),
            trailing: subCategory == selectedCategory
                ? Icon(
                    Icons.check_sharp,
                    color: Color(0xFF1D9E6A),
                  )
                : Icon(Icons.keyboard_arrow_right_sharp),
          );
        }
        return buildExpansionTile(subCategory);
      }),
      onExpansionChanged: (bool expanded) {
        setState(() {
          currentCategory.isExpanded = expanded;
          if (currentCategory.isExpanded) {
            if (selectedPath.length > currentCategory.level + 1) {
              selectedPath.removeAt(currentCategory.level + 1);
            }
            selectedPath.insert(
                currentCategory.level + 1, currentCategory.name);
          }
        });
      },
    );
  }

  double getPadding(int currentCategoryLevel) {
    switch (currentCategoryLevel) {
      case -1:
        return 0;
        break;
      case 0:
        return 0;
        break;
      case 1:
        return 15;
        break;
      case 2:
        return 30;
        break;
      default:
        0;
    }
    return 0;
  }

  TextStyle getStyle(int currentCategoryLevel, bool selected) {
    switch (currentCategoryLevel) {
      case -1:
        return FlutterFlowTheme.bodyText1.override(
          color: selected ? Color(0xFF1D9E6A) : Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        );
        break;
      case 0:
        return FlutterFlowTheme.bodyText1.override(
          color: selected ? Color(0xFF1D9E6A) : Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        );
        break;
      case 1:
        return FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: selected ? Color(0xFF1D9E6A) : Colors.black38,
        );
        break;
      case 2:
        return FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: selected ? Color(0xFF1D9E6A) : Colors.black,
        );
        break;
      default:
        FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        );
    }
    return FlutterFlowTheme.bodyText1.override(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    );
  }
}
