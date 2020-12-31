import 'package:flutter_test/flutter_test.dart';

void main() {
  test('regex allMatches', () {
    final template = 'Hello {{firstName}}, {{lastName}}';
    final templateRegExp = RegExp(r'\{\{(\w+)\}\}');

    var matches = templateRegExp.allMatches(template);
    expect(matches.length, 2);
    // matches.forEach((element) {
    //   print('-------');
    // });
    matches.map((match){
      // return match.input.substring(match.start, match.end);
      return '${match.groupCount},${match.group(0)},${match.group(1)}';
    }).forEach((element) {
      print(element);
    });
  });
}