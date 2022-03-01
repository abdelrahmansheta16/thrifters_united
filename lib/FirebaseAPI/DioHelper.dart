import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;
  static double convertRate;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://v6.exchangerate-api.com',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static getData() async {
    init();
    await dio.get(
      '/v6/815a899e0965ee3c559bf89c/pair/EGP/USD',
      // queryParameters: {
      //   'q': 'EGP_USD',
      //   'compact': 'ultra',
      //   'apiKey': '808d6e3d9f97ccc6821d',
      // },
    ).then((value) {
      convertRate = value.data['conversion_rate'];
    }).catchError((onError) {
      print(onError);
    });
  }
}
