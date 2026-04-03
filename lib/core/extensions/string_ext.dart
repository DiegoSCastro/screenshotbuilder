
extension StringExt on String {
  /// [capitalize] will make first letter capital of a string
  /// ```
  ///  //example
  /// final str="hello world"
  /// final strConverted=str.capitalize
  /// print(strConverted);//Hello world
  /// ```
  String get capitalize =>
      isNotEmpty ? "${this[0].toUpperCase()}${substring(1)}" : "";
}
