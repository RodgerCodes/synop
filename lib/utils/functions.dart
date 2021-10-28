import 'package:flutter/painting.dart';

class RainDuration {
  static int rain(String value) {
    if (value == '6 hours preceding observation') {
      return 1;
    } else if (value == '12 hours preceding observation') {
      return 2;
    } else if (value == '18 hours preceding observation') {
      return 3;
    } else {
      return 4;
    }
  }
}

class PastweatherData {
  static int PastWeatherChecker(String value) {
    if (value == 'Cloud cover 4 oktas or less') {
      return 0;
    } else if (value == 'Cloud cover more than 4 oktas (part of period)') {
      return 1;
    } else if (value == 'Cloud cover more than 4 oktas (whole period)') {
      return 2;
    } else if (value == 'Sandstorm, duststorm or blowing snow') {
      return 3;
    } else if (value == 'Fog or thick haze, visibility below 1000m') {
      return 4;
    } else if (value == 'Drizzle') {
      return 5;
    } else if (value == 'Rain') {
      return 6;
    } else if (value == 'Snow/rain and snow mixed') {
      return 7;
    } else if (value == 'Shower(s)') {
      return 8;
    } else if (value == 'Thunderstorm(s) with/without precipitation') {
      return 9;
    }
  }
}

class WindData {
  static String windDirection(dynamic value) {
    if (value == 'calm') {
      return '00';
    } else if (value >= 5 && value <= 14) {
      return '01';
    } else if (value >= 15 && value <= 24) {
      return '02';
    } else if (value >= 25 && value <= 34) {
      return '03';
    } else if (value >= 35 && value <= 44) {
      return '04';
    } else if (value >= 45 && value <= 54) {
      return '05';
    } else if (value >= 55 && value <= 64) {
      return '06';
    } else if (value >= 65 && value <= 74) {
      return '07';
    } else if (value >= 75 && value <= 84) {
      return '08';
    } else if (value >= 85 && value <= 94) {
      return '09';
    } else if (value >= 95 && value <= 104) {
      return '10';
    } else if (value >= 105 && value <= 114) {
      return '11';
    } else if (value >= 115 && value <= 124) {
      return '12';
    } else if (value >= 125 && value <= 134) {
      return '13';
    } else if (value >= 135 && value <= 144) {
      return '14';
    } else if (value >= 145 && value <= 154) {
      return '15';
    } else if (value >= 155 && value <= 164) {
      return '16';
    } else if (value >= 165 && value <= 174) {
      return '17';
    } else if (value >= 175 && value <= 184) {
      return '18';
    } else if (value >= 185 && value <= 194) {
      return '19';
    } else if (value >= 195 && value <= 204) {
      return '20';
    } else if (value >= 205 && value <= 214) {
      return '21';
    } else if (value >= 215 && value <= 224) {
      return '22';
    } else if (value >= 225 && value <= 234) {
      return '23';
    } else if (value >= 235 && value <= 244) {
      return '24';
    } else if (value >= 245 && value <= 254) {
      return '25';
    } else if (value >= 255 && value <= 264) {
      return '26';
    } else if (value >= 265 && value <= 274) {
      return '27';
    } else if (value >= 275 && value <= 284) {
      return '28';
    } else if (value >= 285 && value <= 294) {
      return '29';
    } else if (value >= 295 && value <= 304) {
      return '30';
    } else if (value >= 305 && value <= 314) {
      return '31';
    } else if (value >= 315 && value <= 324) {
      return '32';
    } else if (value >= 325 && value <= 334) {
      return '33';
    } else if (value >= 335 && value <= 344) {
      return '34';
    } else if (value >= 345 && value <= 354) {
      return '35';
    } else if (value >= 355 || value <= 4) {
      return '36';
    } else if (value == 'variable' ||
        value == 'unknown' ||
        value == 'direction indeterminate' ||
        value == 'all directions') {
      return '99';
    } else {
      return '99';
    }
  }
}

class visibilityinfo {
  static String visibilityData(int value) {
    if (value < 100) {
      return '00';
    } else if (value >= 100 && value < 200) {
      return '01';
    } else if (value >= 100 && value < 300) {
      return '02';
    } else if (value >= 300 && value < 400) {
      return '03';
    } else if (value >= 400 && value < 500) {
      return '04';
    } else if (value >= 500 && value < 600) {
      return '05';
    } else if (value >= 600 && value < 700) {
      return '06';
    } else if (value >= 700 && value < 800) {
      return '07';
    } else if (value >= 800 && value < 900) {
      return '08';
    } else if (value >= 900 && value < 1000) {
      return '09';
    } else if (value >= 1000 && value < 1100) {
      return '10';
    } else if (value >= 1100 && value < 1200) {
      return '11';
    } else if (value >= 1200 && value < 1300) {
      return '12';
    } else if (value >= 1300 && value < 1400) {
      return '13';
    } else if (value >= 1400 && value < 1500) {
      return '14';
    } else if (value >= 1500 && value < 1600) {
      return '15';
    } else if (value >= 1600 && value < 1700) {
      return '16';
    } else if (value >= 1700 && value < 1800) {
      return '17';
    } else if (value >= 1800 && value < 1900) {
      return '18';
    } else if (value >= 1900 && value < 2000) {
      return '19';
    } else if (value >= 2000 && value < 2100) {
      return '20';
    } else if (value >= 2100 && value < 2200) {
      return '21';
    } else if (value >= 2200 && value < 2300) {
      return '22';
    } else if (value >= 2300 && value < 2400) {
      return '23';
    } else if (value >= 2400 && value < 2500) {
      return '24';
    } else if (value >= 2500 && value < 2600) {
      return '25';
    } else if (value >= 2600 && value < 2700) {
      return '26';
    } else if (value >= 2700 && value < 2800) {
      return '27';
    } else if (value >= 2800 && value < 2900) {
      return '28';
    } else if (value >= 2900 && value < 3000) {
      return '29';
    } else if (value >= 3000 && value < 3100) {
      return '30';
    } else if (value >= 3100 && value < 3200) {
      return '31';
    } else if (value >= 3200 && value < 3300) {
      return '32';
    } else if (value >= 3300 && value < 3400) {
      return '33';
    } else if (value >= 3400 && value < 3500) {
      return '34';
    } else if (value >= 3500 && value < 3600) {
      return '35';
    } else if (value >= 3600 && value < 3700) {
      return '36';
    } else if (value >= 3700 && value < 3800) {
      return '37';
    } else if (value >= 3800 && value < 3900) {
      return '38';
    } else if (value >= 3900 && value < 4000) {
      return '39';
    } else if (value >= 4000 && value < 4100) {
      return '40';
    } else if (value >= 4100 && value < 4200) {
      return '41';
    } else if (value >= 4200 && value < 4300) {
      return '42';
    } else if (value >= 4300 && value < 4400) {
      return '43';
    } else if (value >= 4400 && value < 4500) {
      return '44';
    } else if (value >= 4500 && value < 4600) {
      return '45';
    } else if (value >= 4600 && value < 4700) {
      return '46';
    } else if (value >= 4700 && value < 4800) {
      return '47';
    } else if (value >= 4800 && value < 4900) {
      return '48';
    } else if (value >= 4900 && value < 5000) {
      return '49';
    } else if (value == 5000) {
      return '50';
    } else if (value >= 6000 && value < 7000) {
      return '56';
    } else if (value >= 7000 && value < 8000) {
      return '57';
    } else if (value >= 8000 && value < 9000) {
      return '58';
    } else if (value >= 9000 && value < 10000) {
      return '59';
    } else if (value >= 10000 && value < 11000) {
      return '60';
    } else if (value >= 11000 && value < 12000) {
      return '61';
    } else if (value >= 12000 && value < 13000) {
      return '62';
    } else if (value >= 13000 && value < 14000) {
      return '63';
    } else if (value >= 14000 && value < 15000) {
      return '64';
    } else if (value >= 15000 && value < 16000) {
      return '65';
    } else if (value >= 16000 && value < 17000) {
      return '66';
    } else if (value >= 17000 && value < 18000) {
      return '67';
    } else if (value >= 18000 && value < 19000) {
      return '68';
    } else if (value >= 19000 && value < 20000) {
      return '69';
    } else if (value >= 20000 && value < 21000) {
      return '70';
    } else if (value >= 21000 && value < 22000) {
      return '71';
    } else if (value >= 22000 && value < 23000) {
      return '72';
    } else if (value >= 23000 && value < 24000) {
      return '73';
    } else if (value >= 24000 && value < 25000) {
      return '74';
    } else if (value >= 25000 && value < 26000) {
      return '75';
    } else if (value >= 26000 && value < 27000) {
      return '76';
    } else if (value >= 27000 && value < 28000) {
      return '77';
    } else if (value >= 28000 && value < 29000) {
      return '78';
    } else if (value >= 29000 && value < 30000) {
      return '79';
    } else if (value >= 30000 && value < 31000) {
      return '80';
    } else if (value >= 31000 && value < 35000) {
      return '81';
    } else if (value >= 35000 && value < 40000) {
      return '81';
    } else if (value >= 40000 && value < 45000) {
      return '82';
    } else if (value >= 45000 && value < 50000) {
      return '83';
    } else if (value >= 50000 && value < 55000) {
      return '84';
    } else if (value >= 55000 && value < 60000) {
      return '85';
    } else if (value >= 60000 && value < 65000) {
      return '86';
    } else if (value >= 65000 && value < 70000) {
      return '87';
    } else if (value >= 70000 && value < 75000) {
      return '88';
    } else {
      return '89';
    }
  }
}

class LowClouds {
  static String Low(String option) {
    if (option == 'No clouds') {
      return "0";
    } else if (option == 'Cu with little vertical extent/ ragged Cu') {
      return "1";
    } else if (option == 'Moderate/large Cu with/without Sc') {
      return "2";
    } else if (option == 'Cb without anvil shaped') {
      return "3";
    } else if (option == 'SC formed by Spreading of Cu') {
      return "4";
    } else if (option == 'Sc not formed by spreading') {
      return "5";
    } else if (option == 'St more/less Continuous layer') {
      return "6";
    } else if (option == 'Ragged shreds of Cu/St of bad weather') {
      return "7";
    } else if (option == 'Cu & Sc;bases at different levels') {
      return "8";
    } else if (option == 'Cb;top culiform and anvil shaped') {
      return "9";
    } else {
      return "/";
    }
  }
}

class MiddleClouds {
  static String Middle(String option) {
    if (option == 'No clouds') {
      return '0';
    } else if (option == 'Altostratus translucidus') {
      return "1";
    } else if (option == 'Altostratus opacus/nimbostratus') {
      return "2";
    } else if (option == 'translucidus single level') {
      return "3";
    } else if (option == 'patches of altocumulus') {
      return "4";
    } else if (option == 'Altocumulus translucidus bands') {
      return "5";
    } else if (option == 'Altocumulus from spreadind cumulus') {
      return "6";
    } else if (option == 'Altocumulus with altostratus & ns') {
      return "7";
    } else if (option == 'Altocumulus floccus') {
      return "8";
    } else if (option == 'Altocumulus of chaotic sky') {
      return "9";
    } else {
      return "/";
    }
  }
}

class HighClouds {
  static String High(String option) {
    if (option == 'No clouds') {
      return "0";
    } else if (option == 'Cirrus fibratus') {
      return "1";
    } else if (option == 'Cirrus spissatus in patches') {
      return "2";
    } else if (option == 'Cirrus spissatus cululonimbogenitus') {
      return "3";
    } else if (option == 'Cirrus uncinus/fibratus or both') {
      return "4";
    } else if (option == 'Cirrus & Cirrostratus veil < 45') {
      return "5";
    } else if (option == 'Cirrus & Cirrostratus veil > 45') {
      return "6";
    } else if (option == 'Cirrostratus covering sky') {
      return "7";
    } else if (option == 'Cirrostratus not invading sky') {
      return "8";
    } else if (option == 'Cirrocumulus alone/ dominant') {
      return "9";
    } else {
      return "/";
    }
  }
}

// colorC
Color ColorChanger(String option, Color primary, Color secondary) {
  if (option == "Data included") {
    return primary;
  } else {
    return secondary;
  }
}
