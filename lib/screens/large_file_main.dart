import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prac_app2/widgets/bot_nav.dart';

class LargeFileMain extends StatefulWidget {
  LargeFileMain({Key? key}) : super(key: key);

  @override
  _LargeFileMainState createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  final imgUrl =
      'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress';
  bool downloading = false;
  var progressString = '';
  String filePath = '';
  TextEditingController? _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = TextEditingController(
        text:
            'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Large File Example'),
        backgroundColor: Colors.amber,
        title: TextField(
          cursorColor: Colors.green,
          controller: _editingController,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url을 입력하세요',
            prefixIcon: const Icon(Icons.email),
            // fillColor: Colors.red,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 5,
                color: Colors.green),
              borderRadius: BorderRadius.circular(10),
            )
          ),
        ),
      ),
      body: Center(
          child: downloading
              ? SizedBox(
                  height: 120,
                  width: 200,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          'Downloading File: $progressString',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : FutureBuilder<Widget>(
                  future: downloadWidget(filePath),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print('none');
                        return const Text('데이터 없음');
                      case ConnectionState.waiting:
                        print('waiting');
                        return const CircularProgressIndicator();
                      case ConnectionState.active:
                        print('active');
                        return const CircularProgressIndicator();
                      case ConnectionState.done:
                        print('done');
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return snapshot.data as Widget;
                        }
                    }
                    print('end process');
                    return const Text('데이터 없음');
                  },
                )),
      // 다운로드 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: const Icon(Icons.file_download),
      ),
      
    );
  }

  Future<void> downloadFile() async {
    var dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(_editingController!.text, '${dir.path}/myimage.jpg',
          onReceiveProgress: (received, total) {
        // print('Count: $count, Total: $total');
        filePath = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = '${((received / total) * 100).toStringAsFixed(0)}%';
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = 'Completed';
    });

    print(progressString);
  }

  // "future" async function of FutureBuilder
  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();

    if (exist) {
      return Center(
        child: Column(
          children: <Widget>[Image.file(File(filePath))],
        ),
      );
    } else {
      FileImage(file).evict(); // 캐시 초기화
      // 캐시에 같은 이름의 이미지가 있으면 이미지를 변경하지 않고 해당 이미지 사용
      // evict() 함수를 호출해 캐시를 비우면 같은 이름이어도 이미지를 갱신
      print('cash 초기화됨');
      return const Text('No Data');
    }
  }
}
