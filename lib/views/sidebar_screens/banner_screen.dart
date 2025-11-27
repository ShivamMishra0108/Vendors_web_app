import 'package:ecommerce_web_app/controller/banner_controller.dart';
import 'package:ecommerce_web_app/views/sidebar_screens/widget/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BannerScreen extends StatefulWidget {
  static const id = '\bannerScreen';

  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

final BannerController _bannerController = BannerController();

class _BannerScreenState extends State<BannerScreen> {
  dynamic _image;
  late String name;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Banners",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.shade900),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.memory(_image)
                        : Text("Banner"),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text("Cancel")),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    await _bannerController.uploadBanner(
                      pickedImage: _image,
                      context: context,
                    );
                  },
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                pickImage();
              },
              child: Text("Pick Image", style: TextStyle(color: Colors.white)),
            ),
          ),

          Divider(color: Colors.grey.shade900),

          BannerWidget(),
        ],
      ),
    );
  }
}
