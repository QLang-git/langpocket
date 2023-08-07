// ignore: constant_identifier_names

enum Days { sunday, monday, tuesday, wednesday, thursday, friday, saturday }

// Monday: 1
// Tuesday: 2
// Wednesday: 3
// Thursday: 4
// Friday: 5
// Saturday: 6
// Sunday: 7

// ignore: constant_identifier_names
const DEFAULT_DAY_ID = 1000000;

Map<Days, int> notificationDays = {
  Days.monday: DEFAULT_DAY_ID,
  Days.tuesday: DEFAULT_DAY_ID * 2,
  Days.wednesday: DEFAULT_DAY_ID * 3,
  Days.thursday: DEFAULT_DAY_ID * 4,
  Days.friday: DEFAULT_DAY_ID * 5,
  Days.saturday: DEFAULT_DAY_ID * 6,
  Days.sunday: DEFAULT_DAY_ID * 7
};
