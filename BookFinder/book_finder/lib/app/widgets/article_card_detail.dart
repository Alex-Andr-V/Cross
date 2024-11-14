import 'package:book_finder/domain/repository/model/article.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
 import 'package:go_router/go_router.dart';
import 'package:book_finder/app/extensions/widget_extensions.dart';
class ArticleDetailCard extends StatelessWidget {
  final Book article;

  const ArticleDetailCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final info = article.info;

    return InkWell(
      onTap: () {
      },
      borderRadius: BorderRadius.circular(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение книги
          //ClipRRect(
          //  borderRadius: BorderRadius.circular(5),
          //  child: Image.asset(
          //    info.imageLinks.isNotEmpty ? info.imageLinks[0]['thumbnail'] : 'assets/images/book.png', // Показ изображения
          //    width: 100,
          //    height: 100,
          //    fit: BoxFit.cover,
          //  ),
        //  ),
          20.pw, // отступ между картинкой и текстом
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Название книги
                Text(
                  info.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                5.ph, // отступ между названием и авторами
                // Подзаголовок книги
                if (info.subtitle.isNotEmpty) 
                  Text(
                    info.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                  ),
                5.ph, // отступ после подзаголовка
                // Авторы книги
                Text(
                  info.authors.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                5.ph, // отступ между авторами и издателем
                // Издатель книги
                Text(
                  'Publisher: ${info.publisher}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                5.ph, // отступ между издателем и датой публикации
                // Дата публикации книги
                Text(
                  'Published on: ${info.rawPublishedDate}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                10.ph, // отступ перед описанием
                // Описание книги
                Text(
                  info.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
