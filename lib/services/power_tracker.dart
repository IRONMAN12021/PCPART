// ignore_for_file: avoid_print

class PowerUsageTracker {
  // List to hold TDP values of selected components
  List<double> selectedPartsTdp = [];

  // Power safety margin (e.g., 20% overhead)
  final double powerSafetyMargin = 0.2;

  // Function to add the TDP of a new selected part to the tracker
  void addPartTdp(double tdp) {
    selectedPartsTdp.add(tdp);
    print("Added part with TDP: $tdp W");
  }

  // Function to remove the TDP of a removed part
  void removePartTdp(double tdp) {
    selectedPartsTdp.remove(tdp);
    print("Removed part with TDP: $tdp W");
  }

  // Function to calculate total power consumption
  double getTotalPowerUsage() {
    double totalPower = selectedPartsTdp.fold(0, (sum, partTdp) => sum + partTdp);
    return totalPower;
  }

  // Function to calculate recommended PSU wattage based on total power and safety margin
  double getRecommendedPsuWattage() {
    double totalPower = getTotalPowerUsage();
    double recommendedPsu = totalPower * (1 + powerSafetyMargin);
    return recommendedPsu;
  }

  // Function to display current total power usage and recommended PSU wattage
  Map<String, dynamic> displayPowerStats() {
    double totalPower = getTotalPowerUsage();
    double recommendedPsu = getRecommendedPsuWattage();
    return {
      'totalPowerUsage': totalPower,
      'recommendedPsuWattage': recommendedPsu,
      'message': 'Total power usage: ${totalPower.toStringAsFixed(2)} W, Recommended PSU wattage: ${recommendedPsu.toStringAsFixed(2)} W'
    };
  }

  // Function to display a formatted list of selected parts' TDP and their total power usage
  void displayParts() {
    if (selectedPartsTdp.isEmpty) {
      print("No parts selected.");
    } else {
      print("Selected parts and their TDP:");
      for (var partTdp in selectedPartsTdp) {
        print("Part TDP: $partTdp W");
      }
    }
  }
}
