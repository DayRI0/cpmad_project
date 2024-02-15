import '../BusStops.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const String url =
      'http://datamall2.mytransport.sg/ltaodataservice/BusStops';
  static Future<List<Value>> getBusStops() async {
    try {
      final response = await http.get(url, headers: {
        'AccountKey': 'my17g99PSSaxIG4FdCsZrw==',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final BusStops bs = busStopsFromJson(response.body);
        return bs.value;
      } else {
        return List<Value>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Value>();
    }
  }
}
