import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:has_bogor/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../models/ulasans.dart';
import 'ulasan_form_page.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  Future<List<UlasanJson>> fetchUlasanJson(CookieRequest request) async {
    List response = await request.get('http://127.0.0.1:8000/ulasan/json/');    

    List<UlasanJson> ulasanLists = [];
    for (var i in response) {
      ulasanLists.add(UlasanJson.fromJson(i));
    }

    return ulasanLists;
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Daftar Ulasan'),
        actions: [
          InkWell(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UlasanFormPage(
                        isEdit: false,
                      )));
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      drawer: LeftDrawer(),
      body: FutureBuilder(
        future: fetchUlasanJson(request), 
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if ((!snapshot.hasData)) {
              return const Column(
                children: [
                  Text(
                    'Tidak berhasil mendapatkan data',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              List<UlasanJson> ulasanLists = snapshot.data!;

               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                 child: Table(
                  //  border: TableBorder.all(),
                   columnWidths: const {
                     0: FlexColumnWidth(2), 
                     1: FlexColumnWidth(1),
                     2: FlexColumnWidth(3),
                     3: FlexColumnWidth(1.5), 
                   },
                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                   children: List.generate(ulasanLists.length + 1, (index) {
                     if (index == 0) {
                       return TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300
                        ),
                         children: [
                           Text('PRODUK', style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                           Text('RATING',style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                           Text('PESAN',style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                           Text('AKSI',style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),)
                         ]
                       );
                     }
                 
                     UlasanJson thisUlasan = ulasanLists[index-1];
                     return TableRow(
                       decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                       ),
                       children: [
                         Text(thisUlasan.ulasanMakananSouvenirNama.toString()),
                         Text(thisUlasan.rating.toString()),
                         Text(thisUlasan.pesanUlasan.toString()),
                         Row(
                           children: [
                             InkWell(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => UlasanFormPage(
                                   ulasanJson: thisUlasan,
                                   isEdit: true,
                                 )));
                               },
                               child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.orange,
                                child: Icon(Icons.edit, color: Colors.white, size: 20,))),
                             InkWell(
                               onTap: () async {
                                 final response = await request.postJson(
                                     "http://127.0.0.1:8000/ulasan/delete/flutter/",
                                     jsonEncode(<String, String>{
                                       'id': thisUlasan.id.toString()
                                     }),
                                 );
                                 if (context.mounted) {
                                     if (response['message'] != null) {
                                         Navigator.of(context).pop();
                                         Navigator.push(
                                             context,
                                             MaterialPageRoute(builder: (context) => const ReviewScreen()),
                                         );
                                     } else {
                                         ScaffoldMessenger.of(context)
                                             .showSnackBar(const SnackBar(
                                             content:
                                                 Text("Terdapat kesalahan, silakan coba lagi."),
                                         ));
                                     }
                                 }
                               },
                               child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.red,
                                child: const Icon(Icons.delete, size: 20, color: Colors.white,)))
                           ],
                         )
                       ]
                     );
                   }),
                 ),
               );
            }
          }
        }
      )
    );
  }
}
