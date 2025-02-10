import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final Map<String, dynamic> article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClayContainer(
        borderRadius: 15,
        width: 200,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article["cover_image"] != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      article["cover_image"],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 90,
                    ),
                  ),
                // nullの場合は適当なアイコンを表示
                if (article["cover_image"] == null)
                  Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 90,
                      color: Colors.grey,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article["title"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        article["description"],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
