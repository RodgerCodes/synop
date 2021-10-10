import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static SharedPreferences prefs;
}

// colors
Color bgColorSecondary = Colors.blue;
Color textColor = Colors.white;
Color bgPrimary = Colors.blueGrey[700];

List<String> rain_data_availability = [
  'Data included',
  'Precipitation equals 0',
  'Not reported'
];

List<String> lowCloudsOptions = [
  'No clouds',
  'Cu with little vertical extent/ ragged Cu',
  'Moderate/large Cu with/without Sc',
  'Cb without anvil shaped ',
  'SC formed by Spreading of Cu',
  'St more/less Continuous layer',
  'Ragged shreds of Cu/St of bad weather',
  'Cu & Sc;bases at different levels',
  'Cb;top culiform and anvil shaped',
  'Sc,St,Cu,Cb invisible owing to darkness'
];

List<String> middleclouds = [
  'No clouds',
  'Altostratus translucidus',
  'Altostratus opacus/nimbostratus',
  'translucidus single level',
  'patches of altocumulus',
  'Altocumulus translucidus bands',
  'Altocumulus from spreadind cumulus',
  'Altocumulus with altostratus & ns',
  'Altocumulus floccus',
  'Altocumulus of chaotic sky',
  'clouds invisible'
];

List<String> highclouds = [
  'No clouds',
  'Cirrus fibratus',
  'Cirrus spissatus in patches',
  'Cirrus spissatus cululonimbogenitus',
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
