// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class ConnectivityService {
//   final BuildContext context;
//   bool isAlertSet = false;

//   ConnectivityService(this.context);

//   Future<void> checkInternetConnection() async {
//     bool isConnected = await InternetConnectionChecker().hasConnection;
//     if (!isConnected) {
//       if (!isAlertSet) {
//         _showNoConnectionDialog();
//         isAlertSet = true;
//       }
//     } else {
//       isAlertSet = false;
//     }
//   }

//   void _showNoConnectionDialog() {
//     showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('No Connection'),
//         content: const Text('Please check your internet connectivity'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () async {
//               // Recheck the connectivity before closing the dialog
//               bool isConnected =
//                   await InternetConnectionChecker().hasConnection;
//               if (!isConnected) {
//                 // If still not connected, do not close the dialog
//                 if (context.mounted) {
//                   Navigator.of(context, rootNavigator: true).pop('dialog');
//                 }
//                 _showNoConnectionDialog(); // Show the dialog again
//               } else {
//                 // If connected, close the dialog
//                 if (context.mounted) {
//                   Navigator.pop(context, 'Cancel');
//                 }
//                 isAlertSet = false;
//               }
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
