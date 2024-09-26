import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabasewithflutter/main.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool isLoading = false;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload File'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (imageUrl.isEmpty)
            Container(
              width: 150,
              height: 150,
              color: Colors.grey,
              child: const Center(
                child: Text('Sem Imagem'),
              ),
            )
          else
            Image.network(
              imageUrl,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ElevatedButton(
            onPressed: isLoading ? null : upload,
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  Future<void> upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;

      await supabase.storage.from('images').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              contentType: imageFile.mimeType,
            ),
          );

      final imageUrlResponse = await supabase.storage.from('images').createSignedUrl(
            filePath,
            60,
          );

      setState(() {
        imageUrl = imageUrlResponse;
        print(imageUrl);
      });
    } on StorageException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error ocurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
