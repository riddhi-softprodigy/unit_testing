// Import the test package and Counter class
import 'package:audioPlayer/unitTesting/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter(); // Initialization(Arrange)

    counter.increment(); // Exucation(Act)

    expect(counter.value, 1); //Obersation(Assert)
  });
}
