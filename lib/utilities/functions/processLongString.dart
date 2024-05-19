// // this is used to return the substring of a long string
// // that might possibly overflow when put inside a widget

// String processLongString(
//     {required String unProcessedString,
//     required int minimumStringLength,
//     required int substringLength}) {
//   return unProcessedString.length > minimumStringLength
//       ? unProcessedString.substring(0, substringLength) + ".."
//       : unProcessedString;
// }