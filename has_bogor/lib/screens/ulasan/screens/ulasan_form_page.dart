import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../models/katalogs.dart';
import '../models/ulasans.dart';
import 'show_ulasan_page.dart';

class UlasanFormPage extends StatefulWidget {
  final UlasanJson? ulasanJson;
  final bool isEdit;

  const UlasanFormPage({
    this.ulasanJson,
    required this.isEdit,
    super.key
  });

  @override
  State<UlasanFormPage> createState() => _UlasanFormPageState();
}

class _UlasanFormPageState extends State<UlasanFormPage> {
  late UlasanJson? ulasanJson;
  late bool? isEdit;

  final _formKey = GlobalKey<FormState>();
  String _pesanUlasan = "";
  KatalogJson? _katalogPicked;
  int _rating = 0;



  @override
  void initState() {
    // TODO: implement initState
    ulasanJson = widget.ulasanJson;
    isEdit = widget.isEdit;
    if (ulasanJson != null) {
      _pesanUlasan = ulasanJson!.pesanUlasan;
      _katalogPicked = KatalogJson(
        id: ulasanJson!.ulasanMakananSouvenirId, 
        nama: ulasanJson!.ulasanMakananSouvenirNama);
      _rating = ulasanJson!.rating;
    }
    super.initState();
  }

  Future<List<KatalogJson>> fetchUlasanJson(CookieRequest request) async {
    List response = await request.get('http://127.0.0.1:8000/ulasan/show-katalogs/');    

    List<KatalogJson> ulasanLists = [];
    for (var i in response) {
      ulasanLists.add(KatalogJson.fromJson(i));
    }

    return ulasanLists;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isEdit == true
          ? const Text('Edit Ulasan')
          : const Text('Tambah Ulasan'),
      ),
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
              List<KatalogJson> katalogLists = snapshot.data!;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          children: [
                            const SizedBox(height: 30,),
                            DropdownButtonFormField<KatalogJson>(
                              value: _katalogPicked,
                              onChanged: (KatalogJson? newValue) {
                                setState(() {
                                  _katalogPicked = newValue;
                                });
                              },
                              validator: (KatalogJson? value) {
                                if (value == null) {
                                  return "Makanan dan Suvenir perlu terisi!";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Pilih Katalog',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.grey.shade900, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                              ),
                              items: katalogLists.map<DropdownMenuItem<KatalogJson>>((KatalogJson katalog) {
                                return DropdownMenuItem<KatalogJson>(
                                  value: katalog,
                                  child: Text(katalog.nama),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 30,),
                            TextFormField(
                              initialValue: _pesanUlasan,
                              onChanged: (String? value) {
                                setState(() {
                                  _pesanUlasan = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Pesan harus terisi";
                                }
                                return null;
                              },
                              maxLines: 10,
                              decoration: InputDecoration(
                                labelText: 'Pesan',
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.grey.shade900, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(5, (index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (_rating == index + 1) {
                                          _rating = 0;
                                        } else {
                                          _rating = index + 1;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.star,
                                      size: 40,
                                      color: _rating > index ? Colors.yellow : Colors.grey,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10, // Ensures the button spans the full width of its parent
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Add padding if needed
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                    final response = await request.postJson(
                                        isEdit == true
                                          ? "http://127.0.0.1:8000/ulasan/edit/flutter/${ulasanJson!.id}/"
                                          : "http://127.0.0.1:8000/ulasan/create/flutter/",
                                        jsonEncode(<String, String>{
                                            'ulasan_makanan_souvenir' : _katalogPicked!.id.toString(),
                                            'rating' : _rating.toString(),
                                            'pesan_ulasan' : _pesanUlasan,
                                        }),
                                    );
                                    if (context.mounted) {
                                        if (response['status'] == 'success') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                            content: Text("Mood baru berhasil disimpan!"),
                                            ));
                                            Navigator.pop(context);
                                            Navigator.pop(context);
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
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green.shade700,
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              child: const Text("Save"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        }
      )
    );
  }
}