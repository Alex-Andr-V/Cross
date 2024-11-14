import 'package:json_annotation/json_annotation.dart';
part 'article.g.dart';
@JsonSerializable()
class Article {
Article({
required this.title,
    required this.subtitle,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.rawPublishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.averageRating,
    required this.ratingsCount,
    required this.maturityRating,
    required this.contentVersion,
    required this.imageLinks,
    required this.language,
});
final String title;
  final String subtitle;
  final List<String> authors;
  final String publisher;

  @JsonKey(name: 'published_date')
  final DateTime publishedDate;

  @JsonKey(name: 'raw_published_date')
  final String rawPublishedDate;

  final String description;
  
  @JsonKey(name: 'page_count')
  final int pageCount;

  final List<String> categories;

  @JsonKey(name: 'average_rating')
  final double averageRating;

  @JsonKey(name: 'ratings_count')
  final int ratingsCount;

  @JsonKey(name: 'maturity_rating')
  final String maturityRating;

  @JsonKey(name: 'content_version')
  final String contentVersion;

  @JsonKey(name: 'image_links')
  final List<Map<String, Uri>> imageLinks;

  final String language;
factory Article.fromJson(Map<String, dynamic> json) =>
_$ArticleFromJson(json);
Map<String, dynamic> toJson() => _$ArticleToJson(this);
}