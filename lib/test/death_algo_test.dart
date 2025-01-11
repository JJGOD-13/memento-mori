import 'package:memento_mori/src/utils/time_to_live_algo.dart';
import 'package:test/test.dart';

void main() {
  group('test time left to live algo boundary conditions', () {
    test("Age greater than death day should arg error", () {
      expect(() => timeLeftToLive(90, 80), throwsArgumentError);
    });
    test("Age less than 0 throws argument error", () {
      expect(() => timeLeftToLive(-1, 80), throwsArgumentError);
    });
  });

  group("Test time_left_to_live algo correctness", () {
    test("Correct years if age 70 and death 80 ", () {
      final time = timeLeftToLive(70, 80);
      expect(time?.years, 10);
    });
  });
}
