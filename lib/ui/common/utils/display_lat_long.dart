String convertMapToLatLong(Map map) {
  return (map["lat"] == 0 && map["long"] == 0) ||
          (map["lat"] == null && map["long"] == null)
      ? "Enter Location"
      : "${map["lat"]}, ${map["long"]}";
}
