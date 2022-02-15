import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,

        elevation: 0,
        title: Text('Search'),
        centerTitle: true,
        // title: Padding(
        //   padding: const EdgeInsets.only(top: 20),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       border: OutlineInputBorder(),
        //       hintText: 'Enter name of the song'
        //     ),
        //   ),
        // ),
        // leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter name of the song'),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              'Result',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) => ListTile(
                onTap: () => {},
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                title: Text('data'),
                subtitle: Text('data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
