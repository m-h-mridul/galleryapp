
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/Provider/ProviderData.dart';
import 'package:provider/provider.dart';

class listview extends StatelessWidget {
  const listview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ProviderData>(context);
    return  ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: provider.albumData?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.amber,
            child: ListTile(
              title: Text(provider.albumData![index]['id'].toString()),
              isThreeLine: true,
              subtitle:
              Text(provider.albumData![index]['title'].toString()),
              // title: Text((list == null)?'loading':list![index]['title'].toString()),
            ),
          );
        });
  }
}
