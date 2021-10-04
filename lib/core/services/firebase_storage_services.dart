import 'dart:async';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageServices{
  String fileName = "";
  String filePath = "";

  FirebaseStorageServices({ required this.fileName , required this.filePath});



  Future<String> uploadFile( String id  ) async {
    // await firebase_storage.FirebaseStorage.instance.ref().child(id).delete();

    String fileNameFull = fileName;
    if( id != '' ){
      fileNameFull = id + '/' + fileNameFull;
    }
    firebase_storage.UploadTask uploadTask;

    String _extension = fileName.toString().split('.').last;
    final metadata = firebase_storage.SettableMetadata(
        contentType: _extension,
        customMetadata: {'picked-file-path': filePath});


    final firebase_storage.Reference  ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(fileNameFull);



    uploadTask = ref.putFile(io.File(filePath), metadata);

    String returnURL = "";
    // var _returnURL = await ref.getDownloadURL();

    return returnURL.toString();
  }

}
