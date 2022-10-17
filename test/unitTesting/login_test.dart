// import 'package:audioPlayer/unitTesting/mock_testing.dart';

import 'package:audioPlayer/unitTesting/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
void main() {
  group('Login', () {
    test('returns an Success if the http call completes successfully',
        () async {
      Future<Response> requestHandler(Request request) async {
        return http.Response(
            '{"email": "eve.holt@reqres.in", "password": "12345"}', 200);
      }

      final client = MockClient(requestHandler);

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.

      expect(await loginUser(client, "eve.holt@reqres.in", "12345"), "Success");
    });

    test('throws an exception if the http call completes with an error', () {
      Future<Response> requestHandler(Request request) async {
        return http.Response('Not Found', 400);
      }

      final client = MockClient(requestHandler);

      expect(loginUser(client, "eve.holt@reqres.in", "12345"), throwsException);
    });
  });
}
