import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/screens/canidate_legal_info.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SingleDownloadScreen extends StatefulWidget {
  const SingleDownloadScreen({Key? key}) : super(key: key);

  @override
  State<SingleDownloadScreen> createState() => _SingleDownloadScreenState();
}

class _SingleDownloadScreenState extends State<SingleDownloadScreen> {
  double? _progress;
  String _status = '';
  final TextEditingController name = TextEditingController();
  final TextEditingController url = TextEditingController(
    text:
    // 'http://www.africau.edu/images/default/sample.pdf',
    'https://manage.nanirecruitment.com/img/candoc/20230822123141119.pdf',
  );


  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> CanidateLegalInfor(_status)));
          },
          icon: Icon(Icons.arrow_back_ios),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfPdfViewer.network(
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              key: _pdfViewerKey,),
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.teal,
                semanticLabel: 'Bookmark',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
            if (_status.isNotEmpty) ...[
              Text(_status, textAlign: TextAlign.center),
              const SizedBox(height: 16),
            ],
            if (_progress != null) ...[
              LinearProgressIndicator(
                value: _progress! / 100,
              ),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: url,
              decoration: const InputDecoration(label: Text('Url*')),
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(label: Text('File name')),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () async {
              FileDownloader.downloadFile(
                  url: url.text.trim(),
                  name: name.text.trim(),
                  onProgress: (name, progress) {
                    setState(() {
                      _progress = progress;
                      _status = 'dowbloading...: $progress%';
                    });
                  },
                  onDownloadCompleted: (path) {
                    setState(() {
                      _progress = null;
                      _status = 'File downloaded to: $path';
                    });
                  },
                  onDownloadError: (error) {
                    setState(() {
                      _progress = null;
                      _status = 'Download error: $error';
                    });
                  }).then((file) {
                debugPrint('file path: ${file?.path}');
              });
            }, child: const Text('Download')),
          ],
        ),
      ),
    );
  }
}