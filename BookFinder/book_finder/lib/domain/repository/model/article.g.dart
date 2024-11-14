// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      publisher: json['publisher'] as String,
      publishedDate: DateTime.parse(json['published_date'] as String),
      rawPublishedDate: json['raw_published_date'] as String,
      description: json['description'] as String,
      pageCount: (json['page_count'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      averageRating: (json['average_rating'] as num).toDouble(),
      ratingsCount: (json['ratings_count'] as num).toInt(),
      maturityRating: json['maturity_rating'] as String,
      contentVersion: json['content_version'] as String,
      imageLinks: (json['image_links'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, Uri.parse(e as String)),
              ))
          .toList(),
      language: json['language'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'published_date': instance.publishedDate.toIso8601String(),
      'raw_published_date': instance.rawPublishedDate,
      'description': instance.description,
      'page_count': instance.pageCount,
      'categories': instance.categories,
      'average_rating': instance.averageRating,
      'ratings_count': instance.ratingsCount,
      'maturity_rating': instance.maturityRating,
      'content_version': instance.contentVersion,
      'image_links': instance.imageLinks
          .map((e) => e.map((k, e) => MapEntry(k, e.toString())))
          .toList(),
      'language': instance.language,
    };
