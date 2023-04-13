
import 'dart:io';

abstract class UploadState{}

class UploadInit extends UploadState{}

class UploadLoad extends UploadState{

  File? image;
  UploadLoad(this.image);

}

class UploadError extends UploadState{
  String msg;
  UploadError(this.msg);
}

class UploadSuccess extends UploadState{

}