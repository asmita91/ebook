import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/ViewModel/BookViewModel.dart';
import 'package:ebook/models/bookmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/expandableText.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BookViewModel _bookViewModel;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Cannot launch";
    }
  }

  @override
  void initState() {
    _bookViewModel = Provider.of<BookViewModel>(context, listen: false);
    _bookViewModel.getBook();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var book = context.watch<BookViewModel>().book;

    return Scaffold(
      appBar: AppBar(
        title: Text('Books Collection'),
      ),
      body: StreamBuilder(
        stream: book,
        builder: (context, AsyncSnapshot<QuerySnapshot<BookModel>> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return ListView(children: [
                ...snapshot.data!.docs.map((document) {
                  BookModel book = document.data();
                  return ListTile(
                    leading: Container(
                      width: MediaQuery.of(context).size.height / 10,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${book.thumbnailurl}"
                              // document.data()['thumbnailurl']
                              ),
                        ),
                      ),
                    ),
                    title: Text(book.name,
                        // document.data()['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.author,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey),
                        ),
                        Expanded(
                          flex: 0,
                          child: ExpandableTextWidget(
                              Des_text: "${book.description}"),
                        ),
                        Center(
                          // child: Link(
                          //     target: LinkTarget.blank,
                          //     uri: Uri.parse(book.bookurl),
                          //     builder: (context, followLink) =>
                          //         GestureDetector(
                          //           onTap: followLink,
                          //           child: Text(
                          //             "Read Book",
                          //             style: TextStyle(
                          //                 color: Colors.blue,
                          //                 decoration:
                          //                     TextDecoration.underline),
                          //           ),
                          //         )))
                          child: GestureDetector(
                            onTap: () {
                              _launchUrl(book.bookurl);
                            },
                            child: Text("Read Book",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)),
                          ),
                        )
                      ],
                    ),
                  );
                })
              ]);
          }
        },
      ),
    );
  }
}
