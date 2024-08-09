import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int index; // Index to show the specific news

  const NewsDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  color: theme.textTheme.headline6!.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(color: theme.textTheme.bodyText2!.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
