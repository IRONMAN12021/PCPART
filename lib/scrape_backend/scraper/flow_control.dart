// File: flow_control.dart
import 'lttlabs.dart';
import 'zttlabs.dart';
import 'passmark.dart';
import 'Threedmark.dart';
import 'pugetbench.dart';
import 'cinebench.dart';
import 'anandtech.dart';
import 'tomshardware.dart';
import 'techpowerup.dart';
import 'techspot.dart';
import 'Userbenchmark.dart';
import 'hardwarecanuncks.dart';
import 'pcpartpicker.dart';


class FlowControl {
  static Future<Map<String, dynamic>> fetchAggregatedData() async {
    try {
      final lttData = await LTTLabsScraper.scrape();
      final zttData = await ZTTLabsScraper.scrape();
      final passMarkData = await PassMarkScraper.scrape();
      final threeDMarkData = await ThreeDMarkScraper.scrape();
      final pugetBenchData = await PugetBenchScraper.scrape();
      final cinebenchData = await CinebenchScraper.scrape();
      final anandTechData = await AnandTechScraper.scrape();
      final tomsHardwareData = await TomsHardwareScraper.scrape();
      final techpowerup = await TechPowerUp.scrape();
      final techspot = await TechSpot.scrape();
      final hardwarecanuncks = await HardwareCanuncks.scrape();
      final userbenchmark = await UserBenchmark.scrape();
      final pcpartpicker = await PCPartPicker.scrape();

      return {
        'LTTLabs': lttData,
        'ZTTLabs': zttData,
        'PassMark': passMarkData,
        '3DMark': threeDMarkData,
        'PugetBench': pugetBenchData,
        'Cinebench': cinebenchData,
        'AnandTech': anandTechData,
        'TomsHardware': tomsHardwareData,
        'TechPowerUp' : techpowerup,
        'TechSpot' : techspot
        'HardwareCanuncks' : hardwarecanucks,
        'UserBenchmark' : userbenchmark,
        'PCPartPicker' : pcpartpicker
      };
    } catch (e) {
      print('Error aggregating benchmark data: $e');
      return {};
    }
  }
}
