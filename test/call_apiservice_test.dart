import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/data/response/restaurant_result.dart';

import 'api_test_mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('listRestaurant', () {
    test('return a List Restaurant if the http call completes successfully',
            () async {
          final client = MockClient();

          when(client.get(Uri.parse(ApiService.baseUrl + '/list'))).thenAnswer(
                  (_) async => http.Response(
                  '{"error": false,"message": "success","count": 20,"restaurants": []}',
                  200));

          expect(await ApiService(client: client).listRestaurants(),
              isA<RestaurantResult>());
        });
    test('throws an exception if the http call completes with an error',
            () async {
          final client = MockClient();

          when(client.get(Uri.parse(ApiService.baseUrl + '/list')))
              .thenAnswer((_) async => http.Response('Not Found', 200));
          expect(ApiService(client: client).listRestaurants(),
              throwsException);
        });
  });
}