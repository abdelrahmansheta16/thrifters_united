import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;
  static double convertRate;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://free.currconv.com',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static getData() async {
    init();
    await dio.get(
      '/api/v7/convert',
      queryParameters: {
        'q': 'EGP_USD',
        'compact': 'ultra',
        'apiKey': '808d6e3d9f97ccc6821d',
      },
    ).then((value) {
      convertRate = value.data['EGP_USD'];
    }).catchError((onError) {
      print(onError);
    });
  }
}
