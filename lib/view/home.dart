import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity package
import 'package:newsflash/model/news_infoModel.dart';
import 'package:newsflash/provider/api_provider.dart';
import 'package:newsflash/provider/bubleimage_provider.dart';
import 'package:newsflash/provider/pickimage_provider.dart';
import 'package:newsflash/widget/custom_dialog.dart';
import 'package:newsflash/widget/custom_view_Card.dart';
import 'package:newsflash/widget/welcome.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NewsResponse? _newsResponse;
  bool _isLoading = true;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });

    if (_isConnected) {
      _fetchNews();
    }
    else{
      _fetchNews();
    }
  }

  Future<void> _fetchNews() async {
    try {
      final response = await fetchNews();
      setState(() {
        _newsResponse = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseUser = Provider.of<UserProvider>(context);
    final imageDecode = Provider.of<PickImageProvider>(context, listen: false);
    final showBubbles = Provider.of<BubbleProvider>(context, listen: false);
    databaseUser.getAllData();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('news_flash'.tr(), style: Theme.of(context).textTheme.titleMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _checkConnectivity();
                  },
                  icon: Icon(
                    Icons.refresh_sharp,
                    size: 32,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder()),
                  ),
                  onPressed: () {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                          () => showDialog(
                        context: context,
                        builder: (context) => CustomProfile(),
                      ),
                    );
                  },
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) {
                      if (value.data.isEmpty) {
                        return const CircleAvatar(
                          backgroundImage:
                          AssetImage('assets/image/robot.png'),
                          backgroundColor: Colors.blue,
                        );
                      } else if (value.data[0].image == null) {
                        return const Icon(size: 16, Icons.people);
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.blue,
                          backgroundImage: FileImage(imageDecode
                              .imageConvert(File(value.data[0].image!))),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : !_isConnected
          ? WelcomeWidget(message: 'Please check your internet connection !',)
          : _newsResponse == null || _newsResponse!.articles.isEmpty
          ? WelcomeWidget(message: 'News Article Are Empty! \ncheck your internet connection',)
          : ListView.builder(
        itemCount: _newsResponse!.articles.length,
        itemBuilder: (context, index) {
          final article = _newsResponse!.articles[index];
          return NoticeWidget(
            index: index,
            title: article.title,
            description: article.description,
            imageUrl: article.urlToImage,
          );
        },
      ),
    );
  }
}
