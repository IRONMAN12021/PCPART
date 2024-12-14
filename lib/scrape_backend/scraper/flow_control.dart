// File: flow_control.dart
import 'ltt_labs.dart';
import 'ztt_labs.dart';
import 'passmark.dart';
import 'three_d_mark.dart';
import 'puget_bench.dart';
import 'cinebench.dart';
import 'anandtech.dart';
import 'tomshardware.dart';
import 'techpowerup.dart';
import 'techspot.dart';
import 'userbenchmark.dart';
import 'hardware_canucks.dart';
import 'pcpartpicker.dart';


class FlowControl {
  static Future<Map<String, dynamic>> fetchAggregatedData() async {
    try {
      final lttData = await LTTLabs.scrape();
      final zttData = await ZTTLabs.scrape();
      final passMarkData = await PassMark.scrape();
      final threeDMarkData = await ThreeDMark.scrape();
      final pugetBenchData = await PugetBench.scrape();
      final cinebenchData = await Cinebench.scrape();
      final anandTechData = await AnandTech.scrape();
      final tomsHardwareData = await TomsHardware.scrape();
      final techPowerUpData = await TechPowerUp.scrape();
      final techSpotData = await TechSpot.scrape();
      final hardwareCanucksData = await HardwareCanucks.scrape();
      final userBenchmarkData = await UserBenchmark.scrape();
      final pcPartPickerData = await PCPartPicker.scrape();

      return {
        'LTTLabs': lttData,
        'ZTTLabs': zttData,
        'PassMark': passMarkData,
        '3DMark': threeDMarkData,
        'PugetBench': pugetBenchData,
        'Cinebench': cinebenchData,
        'AnandTech': anandTechData,
        'TomsHardware': tomsHardwareData,
        'TechPowerUp': techPowerUpData,
        'TechSpot': techSpotData,
        'HardwareCanucks': hardwareCanucksData,
        'UserBenchmark': userBenchmarkData,
        'PCPartPicker': pcPartPickerData,
      };
    } catch (e) {
      print('Error aggregating benchmark data: $e');
      return {};
    }
  }
}
