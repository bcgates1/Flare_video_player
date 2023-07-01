import 'package:fluttertoast/fluttertoast.dart';

toastMessage({required String message}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    // There are other options for gravity, check the documentation
  );
}
