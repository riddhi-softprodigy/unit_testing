// Import the test package and Counter class
import 'package:audioPlayer/unitTesting/field_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validation', () {
    test('Empty Email Test', () {
      var result = FieldValidator.validateEmail('');
      expect(result, 'Enter Email');
    });
    test('Invalid Email Test', () {
      var result = FieldValidator.validateEmail('abcd');
      expect(result, 'Enter valid Email');
    });
    test('Valid Email Test', () {
      var result = FieldValidator.validateEmail('abcd@gmail.com');
      expect(result, null);
    });

    test('Empty Password Test', () {
      var result = FieldValidator.validatePassword('');
      expect(result, 'Enter Password');
    });
    test('Invalid Password Test', () {
      var result = FieldValidator.validatePassword('abcd');
      expect(result, 'Password must be more than 6 charater');
    });
    test('Valid Password Test', () {
      var result = FieldValidator.validatePassword('abcd1234');
      expect(result, null);
    });
  });
}
