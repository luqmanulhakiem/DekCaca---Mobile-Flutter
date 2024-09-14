double tempParser(String temperature) {
  RegExp exp = RegExp(r'([0-9]+(\.[0-9]+)?)');
  String? match = exp.stringMatch(temperature);

  double tempValue = double.parse(match.toString());
  return tempValue;
}
