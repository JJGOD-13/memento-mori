import 'dart:collection';

Map<String, int>? timeLeftToLive(int? age, int? deathYear) {
  /* Returns a hashmap containing the keys:
    Days
    Weeks
    Months
    Years
    Corresponding to the time that user has left to live.
   */

  if (age == null || deathYear == null){
    return null;
  }
  if (age >= deathYear){
    throw ArgumentError("Age must be lower than deathYear")
  }

  int yearsToLive = deathYear - age;
  
  // Calculate months left to live
  int monthsToLive = yearsToLive * 12;

  // Calculate days left to live
  int weeksToLive = monthsToLive * 4;

  // Calculate days left to live

  int daysToLive = weeksToLive * 7;

  final Map<String, int> retMap = HashMap();

  retMap["Years"] = yearsToLive;
  retMap["Months"] = monthsToLive;
  retMap["Weeks"] = weeksToLive;
  retMap["Days"] = daysToLive;

  return retMap;
}
