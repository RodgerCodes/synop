import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static SharedPreferences prefs;
}

List<String> rain_data_availability = [
  'Data included',
  'Precipitation equals 0',
  'Not reported'
];

List<String> present_past_data = [
  'Data included',
  'No significant Phenomena',
  'Not available'
];

List<String> rainDuration = [
  '6 hours preceding observation',
  '12 hours preceding observation',
  '18 hours preceding observation',
  '24 hours preceding observation'
];

List<String> pastWeather = [
  'Cloud cover 4 oktas or less',
  'Cloud cover more than 4 oktas (part of period)',
  'Cloud cover more than 4 oktas (whole period)',
  'Sandstorm, duststorm or blowing snow',
  'Fog or thick haze, visibility below 1000m',
  'Drizzle',
  'Rain',
  'Snow/rain and snow mixed',
  'Shower(s)',
  'Thunderstorm(s) with/without precipitation'
];

List<String> districts = [
  "Balaka",
  "Blantyre",
  "Chikwawa",
  "Chiradzulu",
  "Chitipa",
  "Dedza",
  "Dowa",
  "Karonga",
  "Kasungu",
  "Likoma",
  "Lilongwe",
  "Machinga",
  "Mangochi",
  "Mchinji",
  "Mulanje",
  "Mwanza",
  "Mzimba",
  "Neno",
  "Ntcheu",
  "NkhataBay",
  "Nkhotakota",
  "Nsanje",
  "Ntchisi",
  "Phalombe",
  "Rumphi",
  "Salima",
  "Thyolo",
  "Zomba"
];

List<String> options = ['About App', 'Logout'];
