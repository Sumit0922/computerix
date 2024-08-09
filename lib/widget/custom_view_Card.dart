import 'package:flutter/material.dart';
import 'package:newsflash/view/news_detail_Screen.dart';

class NoticeWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int index;

  const NoticeWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.dividerColor), // Use theme color
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object? exception, StackTrace? stackTrace) {
                    return Row(
                      children: [
                        Image.asset('assets/image/robot.png', height: 80, width: 80),
                        SizedBox(width: 20),
                        Text(
                          "Image Not Available!",
                          style: TextStyle(
                            color: theme.textTheme.bodyText1!.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              title,
              style: TextStyle(
                color: theme.textTheme.headline6!.color,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: theme.textTheme.bodyText2!.color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                      title: title,
                      imageUrl: imageUrl,
                      description: description,
                      index: index,
                    ),
                  ),
                );
              },
              child: Text(
                'View More',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 1,
            color: theme.dividerColor, // Use theme color
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
