import 'dart:async';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class DocumentInfo {
  final String mainTitle;
  final String otherTitles;
  final List authors;
  final String issueDate;
  final String publisher;
  final String citation;
  final String abstract;
  final String ORCID;
  final String DOI;
  final String Url;
  final String pdf;

  DocumentInfo(
      this.mainTitle,
      this.otherTitles,
      this.authors,
      this.issueDate,
      this.publisher,
      this.citation,
      this.abstract,
      this.ORCID,
      this.DOI,
      this.Url,
      this.pdf);
}

class GetInfo {
  int length = 0;

  Future<DocumentInfo> get(String link) async {
    final response = await http.Client().get(
      Uri.parse(link),
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);

      List titles = document.getElementsByClassName(
        'metadataFieldValue dc_title',
      );
      List otherTitles = document.getElementsByClassName(
        'metadataFieldValue dc_title_alternative',
      );
      List authors = document
          .getElementsByClassName(
            'author',
          );
      List issueDate = document.getElementsByClassName(
        'metadataFieldValue dc_date_issued',
      );
      List publisher = document.getElementsByClassName(
        'metadataFieldValue dc_publisher',
      );
      List citation = document.getElementsByClassName(
        'metadataFieldValue dc_identifier_citation',
      );
      List abstract = document.getElementsByClassName(
        'metadataFieldValue dc_description_abstract',
      );
      List ORCID = document.getElementsByClassName(
        'metadataFieldValue dc_identifier_orcid',
      );
      List DOI = document.getElementsByClassName(
        'metadataFieldValue dc_identifier_doi',
      );
      List Url = document.getElementsByClassName(
        'metadataFieldValue dc_identifier_uri',
      );
      List pdf = document
          .getElementsByClassName(
            'btn btn-primary',
          )
          .where((element) => element.attributes.containsKey('href'))
          .map((e) => e.attributes['href'])
          .toList();
      length = titles.length;
      return  DocumentInfo(
          titles[0].text,
          otherTitles[0].text,
          authors,
          issueDate[0].text,
          publisher[0].text,
          citation[0].text,
          abstract[0].text,
          ORCID[0].text,
          DOI[0].text,
          Url[0].text,
          pdf[0]);
    } else {
      throw Exception();
    }
  }
}
