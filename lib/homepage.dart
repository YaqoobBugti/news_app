import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/modle/article_modle.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ArticleModle> articlemodle = new List<ArticleModle>();
  @override
  initState() {
    News newsClass = News();
    newsClass.getNews();
    articlemodle = newsClass.news;
    super.initState();
  }

  Future<void> launchInWebViewWithDomStorage(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today",
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 700,
          width: double.infinity,
          child: ListView.builder(
            itemCount: articlemodle.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      launchInWebViewWithDomStorage(articlemodle[index].url);
                    },
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.grey[300],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            articlemodle[index].urlToImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(articlemodle[index].author==null?'':articlemodle[index].author),
                      Text(articlemodle[index].publishedAt,
                      style: TextStyle(color: Colors.red)),
                    ],
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  Text(
                    articlemodle[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  Text(articlemodle[index].description,
                      style: TextStyle(color: Colors.black87)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(articlemodle[index].content.toString(),),
                  SizedBox(height: 10,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
