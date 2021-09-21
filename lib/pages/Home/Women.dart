import 'package:flutter/cupertino.dart';
import 'package:thrifters_united/customUi/CategoryWidget.dart';

class Women extends StatefulWidget {
  const Women({Key key}) : super(key: key);

  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      'https://media1.popsugar-assets.com/files/thumbor/z22quvISaDXf8qnf43Pjt6SSsa8/0x0:1493x1493/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2021/04/16/940/n/1922564/cfe0e806607a02e186b0e6.36330996_/i/Basic-Clothing-Women.png',
                ),
                CategoryWidget(
                  label: 'Sportswear',
                  imageUrl:
                      'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/28e57f39-4902-47ed-a7c4-a2c81573dac4/sportswear-mid-rise-7-8-leggings-hqBVwb.png',
                ),
                CategoryWidget(
                  label: 'Beauty',
                  imageUrl:
                      'https://i.pinimg.com/originals/f2/54/42/f25442022fab358f52a5bc9490a37664.jpg',
                ),
                CategoryWidget(
                  label: 'Homeware',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThNxmuGc9Hg6dRChwdobdvGR95yOql46YnLw&usqp=CAU',
                ),
                CategoryWidget(
                  imageUrl:
                      'https://discoverymood.com/wp-content/uploads/2020/04/Mental-Strong-Women-min.jpg',
                  label: 'Thrifters',
                ),
                CategoryWidget(
                  label: 'Bags',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9_L4uIY0WPAEUA4pD9ncQzeJiZNDaXmYU6g&usqp=CAU',
                ),
                CategoryWidget(
                  label: 'Shoes',
                  imageUrl:
                      'https://i.ytimg.com/vi/TglF71febNY/maxresdefault.jpg',
                ),
                CategoryWidget(
                  label: 'Accessories',
                  imageUrl:
                      'https://i.pinimg.com/originals/43/1c/17/431c177e8f79d728cc671003f1ab17cf.jpg',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
