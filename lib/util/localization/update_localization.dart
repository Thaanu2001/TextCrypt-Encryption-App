import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

void main() {
  updateLocalizationFile();
}

Future updateLocalizationFile() async {
  //the document id for your google sheet
  String documentId = "1wvF2_jb7JlwaPOSGwtN8cDDyf9YH7IW2ZGcZw7Ft3mA";
  //the sheetid of your google sheet
  String sheetId = "0";

  String phraseKey = '';
  List<LocalizationModel> localizations = [];
  String localizationFile = """import 'package:get/get.dart';
class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    """;

  try {
    final url =
        'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';

    stdout.writeln('');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Downloading Google sheet url "$url" ...');
    stdout.writeln('---------------------------------------');
    var response = await http
        .get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});

    // print('Google sheet csv:\n ${response.body}');

    final bytes = response.bodyBytes.toList();
    final csv = Stream<List<int>>.fromIterable([bytes]);

    final fields = await csv
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();

    final index = fields[0]
        .cast<String>()
        .map(_uniformizeKey)
        .takeWhile((x) => x.isNotEmpty)
        .toList();

    for (var r = 1; r < fields.length; r++) {
      final rowValues = fields[r];

      /// Creating a map
      final row = Map<String, String>.fromEntries(
        rowValues
            .asMap()
            .entries
            .where(
              (e) => e.key < index.length,
            )
            .map(
              (e) => MapEntry(index[e.key], e.value),
            ),
      );

      row.forEach((key, value) {
        if (key == 'key') {
          phraseKey = value;
        } else {
          bool languageAdded = false;
          for (var element in localizations) {
            if (element.language == key) {
              element.phrases.add(PhraseModel(key: phraseKey, phrase: value));
              languageAdded = true;
            }
          }
          if (languageAdded == false) {
            localizations.add(LocalizationModel(
                language: key,
                phrases: [PhraseModel(key: phraseKey, phrase: value)]));
          }
        }
      });
    }

    for (var localization in localizations) {
      String language = localization.language;
      String currentLanguageTextCode = "'$language': {\n";
      localizationFile = localizationFile + currentLanguageTextCode;
      for (var phrase in localization.phrases) {
        String phraseKey = phrase.key;
        String phrasePhrase = phrase.phrase.replaceAll(r"'", "\\'");
        String currentPhraseTextCode = "'$phraseKey': '$phrasePhrase',\n";
        localizationFile = localizationFile + currentPhraseTextCode;
      }
      String currentLanguageCodeEnding = "},\n";
      localizationFile = localizationFile + currentLanguageCodeEnding;
    }
    String fileEnding = """
        };
      }
      """;
    localizationFile = localizationFile + fileEnding;

    stdout.writeln('');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Saving localization.g.dart');
    stdout.writeln('---------------------------------------');
    final file = File('localization.g.dart');
    await file.writeAsString(localizationFile);
    stdout.writeln('Done...');
  } catch (e) {
    //output error
    stderr.writeln('error: networking error');
    stderr.writeln(e.toString());
  }
}

String _uniformizeKey(String key) {
  key = key.trim().replaceAll('\n', '').toLowerCase();
  return key;
}

//Localization Model
class LocalizationModel {
  final String language;
  final List<PhraseModel> phrases;

  LocalizationModel({
    required this.language,
    required this.phrases,
  });

  factory LocalizationModel.fromMap(Map data) {
    return LocalizationModel(
      language: data['language'],
      phrases:
          (data['phrases'] as List).map((v) => PhraseModel.fromMap(v)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "phrases": List<dynamic>.from(phrases.map((x) => x.toJson())),
      };
}

class PhraseModel {
  String key;
  String phrase;

  PhraseModel({required this.key, required this.phrase});

  factory PhraseModel.fromMap(Map data) {
    return PhraseModel(
      key: data['key'],
      phrase: data['phrase'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "key": key,
        "phrase": phrase,
      };
}
