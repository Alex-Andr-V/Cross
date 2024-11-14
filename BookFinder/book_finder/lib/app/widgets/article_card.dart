import 'package:book_finder/domain/repository/model/article.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
 import 'package:go_router/go_router.dart';
import 'package:book_finder/app/extensions/widget_extensions.dart';
import 'package:book_finder/lib/globals.dart' as globals;
class ArticleCard extends StatelessWidget {
 ArticleCard({
super.key, required Book this.article,
});

  final Book article;
@override
Widget build(BuildContext context) {
return InkWell(
onTap: () {
// для следующей лабораторной работы
          context.go('/home/article/${article.id}');
          globals.i =article.id;
},
borderRadius: BorderRadius.circular(5),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
ClipRRect(
borderRadius: BorderRadius.circular(5),
child: Image.asset(
width: 100,
height: 100,
'assets/images/book.png',
fit: BoxFit.cover,
),
),
20.pw,
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
  
article.info.title,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: Theme.of(context).textTheme.titleLarge,
),
5.ph,
Text(
article.info.authors.join(', '),
maxLines: 4,
overflow: TextOverflow.ellipsis,
style: Theme.of(context).textTheme.bodyLarge,
),
],
),
),
],
),
);
}
}