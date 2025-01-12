import 'package:memento_mori/src/utils/enums.dart';

class Expectancy {
  int? days;
  int? weeks;
  int? months;
  int? years;

  Expectancy(this.days, this.months, this.weeks, this.years);

  static Expectancy fromJson(Map<String, dynamic> jsonDecode) {
    return Expectancy(
      jsonDecode['days'],
      jsonDecode['months'],
      jsonDecode['weeks'],
      jsonDecode['years'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'weeks': weeks,
      'months': months,
      'years': years,
    };
  }

  void clear() {
    days = 0;
    weeks = 0;
    months = 0;
    years = 0;
  }

  /// Return the corresponding death format based on the
  /// user specified UserDisplayPreference
  int fromDisplayPref(UserDisplayPreferences usrDispPref) {
    switch (usrDispPref) {
      case UserDisplayPreferences.days:
        return days!;
      case UserDisplayPreferences.weeks:
        return weeks!;
      case UserDisplayPreferences.months:
        return months!;
      case UserDisplayPreferences.years:
        return years!;
    }
  }
}

Expectancy? timeLeftToLive(int? age, int deathYear) {
  /* Returns a Expectancy object containing the keys:
    Days
    Weeks
    Months
    Years
    Corresponding to the time that user has left to live.
   */

  if (age == null) {
    return null;
  }
  if (age <= 0) {
    throw ArgumentError("Age can't be <= 0");
  }
  if (age >= deathYear) {
    throw ArgumentError("Age must be lower than deathYear");
  }
  if (deathYear <= 0) {
    throw ArgumentError("DeathYear can't be <= 0");
  }

  int yearsToLive = deathYear - age;

  // Calculate months left to live
  int monthsToLive = yearsToLive * 12;

  // Calculate days left to live
  int weeksToLive = monthsToLive * 4;

  // Calculate days left to live

  int daysToLive = weeksToLive * 7;

  final Expectancy retMap =
      Expectancy(daysToLive, monthsToLive, weeksToLive, yearsToLive);

  return retMap;
}
