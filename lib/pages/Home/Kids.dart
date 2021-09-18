import 'package:flutter/cupertino.dart';
import 'package:thrifters_united/customUi/CategoryWidget.dart';

class Kids extends StatefulWidget {
  const Kids({Key key}) : super(key: key);

  @override
  _KidsState createState() => _KidsState();
}

class _KidsState extends State<Kids> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhRJHe1C8ykR0J53c45ssHiqE7Lge5KgatGQ&usqp=CAU',
              ),
              CategoryWidget(
                label: 'Sportswear',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_0bY57sILftqZPyQu5SIpDLUWR3VwXVXELA&usqp=CAU',
              ),
              CategoryWidget(
                label: 'Girls',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnrRAjZLDMSalTHMT031OsSO_tgdv1abGx7A&usqp=CAU',
              ),
              CategoryWidget(
                label: 'Homeware',
                imageUrl:
                    'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/newscms/2020_12/1549418/educational-toys-kids-coronavirus-code-botzee-today-main1-200317.jpg',
              ),
              CategoryWidget(
                imageUrl:
                    'https://previews.123rf.com/images/gekaskr/gekaskr1505/gekaskr150500131/39648734-kids-stuff-and-sweets-on-a-white-background.jpg',
                label: 'Thrifters',
              ),
              CategoryWidget(
                label: 'Bags',
                imageUrl:
                    'https://sc04.alicdn.com/kf/Hca970085fa664a3e9748bc6e20cab23fP.jpg',
              ),
              CategoryWidget(
                label: 'Boys',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-bzkIvvPtgGANAUMD5ASQfrXJ4f-DbEH_rg&usqp=CAU',
              ),
              CategoryWidget(
                label: 'Baby',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4yHXeCMyE5jiXvXOnKInd7p_OTeL1XsCF0A&usqp=CAU',
              )
            ],
          ),
        ),
        Expanded(
          child: GridView(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            scrollDirection: Axis.vertical,
            children: [],
          ),
        )
      ],
    );
  }
}
