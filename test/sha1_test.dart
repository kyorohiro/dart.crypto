import 'dart:typed_data' show Uint8List;
import 'package:dart.crypto/sha1.dart';
import 'package:crypto/crypto.dart' as cry;
import 'dart:math' as math;

void main() {
  for(int i=0;i<10;i++) {
    a(10);
  }
}
void a(int count){
  int size = 1024*1024 ~/ 1;
  Uint8List data = new Uint8List(size);
  math.Random r = new math.Random();
  List<int> exp;
  for (int i = 0; i < size; i++) {
    data[i] = r.nextInt(0xff) & 0xff;
  }

  {
    int d1 = new DateTime.now().millisecondsSinceEpoch;
    cry.Digest v;
    for (int i = 0; i < count; i++) {
      cry.Hash sha1 = cry.sha1;
      //v = sha1.convert(data.sublist(0,size~/2));
      //v = sha1.convert(data.sublist(size~/2));
      v = sha1.convert(data);
    }
    int d2 = new DateTime.now().millisecondsSinceEpoch;
    print(" ${v.bytes}  ${d2-d1}");
    exp = v.bytes;
  }
  {
    int d1 = new DateTime.now().millisecondsSinceEpoch;
    List<int> v;
    SHA1 sha = new SHA1();
    Uint8List output = new Uint8List(20);
    for (int i = 0; i < count; i++) {
      sha.sha1Reset();
      sha.sha1Input(data.sublist(0,size~/2),size~/2);
      sha.sha1Input(data.sublist(size~/2),size~/2);
      //sha.sha1Input(data,size);
      v = sha.sha1Result(output: output);
    }
    int d2 = new DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < v.length; i++) {
      if(v[i] != exp[i]) {
        throw "t";
      }
    }
    print(" ${v}  ${d2-d1}");
  }
}