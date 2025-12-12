// import 'package:country_codes/country_codes.dart';
import 'dart:developer';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:url_launcher/url_launcher.dart';

import 'constants/sizes.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'enums.dart';

class AppUtils {
  static PlatformFile? _selectedFile;
  static PlatformFile? get selectedFile => _selectedFile;


  static showToastMessage(message, {ToastType toastType = ToastType.message}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastType == ToastType.message
            ? Colors.black
            : toastType == ToastType.warning
            ? Colors.yellow
            : toastType == ToastType.error
            ? Colors.red
            : Colors.green,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  static void showSnackbar(
    BuildContext context,
    String message, {
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    if (position == SnackBarPosition.bottom) {
      final snackBar = SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final overlay = Overlay.of(context);
      late OverlayEntry overlayEntry;

      final topPadding = MediaQuery.of(context).padding.top;
      final topPosition = AppSizes.appBarHeight + topPadding;

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: topPosition,
          left: 2,
          right: 2,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      overlayEntry.remove();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      overlay.insert(overlayEntry);
      Future.delayed(const Duration(seconds: 3), () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      });
    }
  }

  static void showCustomDialog(context, {required Widget child}) {
    showDialog(context: context, builder: (context) => child);
  }

  // File picker utility
  static Future<PlatformFile?> pickFile({FileType? type}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: type ?? FileType.any);

    if (result != null) {
      _selectedFile = result.files.first;
    } else {
      _selectedFile = null;
    }
    return _selectedFile;
  }

  //Hyphen remover
  static String removeHyphens(String input) {
    return input.replaceAll('-', '');
  }

  static bool isNumeric(String input) {
    final numericRegExp = RegExp(r'^\d+$');
    return numericRegExp.hasMatch(input);
  }

  // Future<String?> downloadAndCacheImage(String? imageUrl) async {
  //   if (imageUrl == null) {
  //     return null;
  //   }
  //   final directory = await getApplicationDocumentsDirectory();
  //   final filePath = '${directory.path}/cached_profile_image.png';
  //
  //   final response = await http.get(Uri.parse(imageUrl));
  //   if (response.statusCode == 200) {
  //     final file = File(filePath);
  //     await file.writeAsBytes(response.bodyBytes);
  //     return filePath;
  //   } else {
  //     throw Exception('Failed to download image');
  //   }
  // }

  // Future<String> getMimeType(String path) async {
  //   String? mimeType = lookupMimeType(path);
  //
  //   // If MIME type cannot be determined, fallback to default
  //   if (mimeType == null) {
  //     mimeType = 'application/octet-stream';
  //   }
  //   return mimeType;
  // }

  static Future<DateTime?> datePicker(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((date) {
      if (date != null) {
        return date;
      }
      return null;
    });
  }

  static Future<int?> yearPicker(BuildContext context, int? currentSelected) {
    DateTime currentDate = DateTime.now();
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int selectedYear = currentDate.year;
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            width: 300,
            height: 200,
            child: YearPicker(
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              selectedDate: DateTime(currentSelected ?? selectedYear),
              onChanged: (DateTime dateTime) {
                Navigator.pop(context, dateTime.year);
              },
            ),
          ),
        );
      },
    );
  }

  static String getFileName(String fileNameWithTimestamp) {
    return fileNameWithTimestamp.split('#').first;
  }

  static String extractCountryCode(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return '91';
    }
    // Find the index of the first space
    int spaceIndex = phoneNumber.indexOf(' ');
    // If no space found, return substring excluding the first character
    if (spaceIndex == -1) {
      return phoneNumber.substring(1);
    }
    // Return substring from second character to the first space found
    return phoneNumber.substring(1, spaceIndex);
  }

  static String extractPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return '';
    }
    // Find the last index of space
    int spaceIndex = phoneNumber.lastIndexOf(' ');
    // If no space found, return the entire input string
    if (spaceIndex == -1) {
      return phoneNumber;
    }
    // Return substring from last index to the end
    return phoneNumber.substring(spaceIndex + 1);
  }

  static Country findCountryByPhoneCode(String phoneCode) {
    return CountryPickerUtils.getCountryByPhoneCode(phoneCode);
  }

  static Future<void> launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showSnackbar(context, 'Could not launch $url');
    }
  }

  // static Future<void> openFile(String filePath, BuildContext context) async {
  //   print(filePath);
  //   // Request necessary permissions
  //   if (await Permission.storage.request().isGranted) {
  //     try {
  //       final result = await OpenFile.open(filePath);
  //       if (result.type != ResultType.done) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Could not open the document')),
  //         );
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Error opening the document')),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Storage permission is denied')),
  //     );
  //   }
  // }

  static String? convertIso3ToIso2(String iso3) {
    if(iso3 == '0'){
     return null;
    }
    return  iso3ToIso2[iso3];
  }

  static Map<String, String> iso3ToIso2 = {
    "BGD": "BD",
    "BEL": "BE",
    "BFA": "BF",
    "BGR": "BG",
    "BIH": "BA",
    "BRB": "BB",
    "WLF": "WF",
    "BLM": "BL",
    "BMU": "BM",
    "BRN": "BN",
    "BOL": "BO",
    "BHR": "BH",
    "BDI": "BI",
    "BEN": "BJ",
    "BTN": "BT",
    "JAM": "JM",
    "BVT": "BV",
    "BWA": "BW",
    "WSM": "WS",
    "BES": "BQ",
    "BRA": "BR",
    "BHS": "BS",
    "JEY": "JE",
    "BLR": "BY",
    "BLZ": "BZ",
    "RUS": "RU",
    "RWA": "RW",
    "SRB": "RS",
    "TLS": "TL",
    "REU": "RE",
    "TKM": "TM",
    "TJK": "TJ",
    "ROU": "RO",
    "TKL": "TK",
    "GNB": "GW",
    "GUM": "GU",
    "GTM": "GT",
    "SGS": "GS",
    "GRC": "GR",
    "GNQ": "GQ",
    "GLP": "GP",
    "JPN": "JP",
    "GUY": "GY",
    "GGY": "GG",
    "GUF": "GF",
    "GEO": "GE",
    "GRD": "GD",
    "GBR": "GB",
    "GAB": "GA",
    "SLV": "SV",
    "GIN": "GN",
    "GMB": "GM",
    "GRL": "GL",
    "GIB": "GI",
    "GHA": "GH",
    "OMN": "OM",
    "TUN": "TN",
    "JOR": "JO",
    "HRV": "HR",
    "HTI": "HT",
    "HUN": "HU",
    "HKG": "HK",
    "HND": "HN",
    "HMD": "HM",
    "VEN": "VE",
    "PRI": "PR",
    "PSE": "PS",
    "PLW": "PW",
    "PRT": "PT",
    "SJM": "SJ",
    "PRY": "PY",
    "IRQ": "IQ",
    "PAN": "PA",
    "PYF": "PF",
    "PNG": "PG",
    "PER": "PE",
    "PAK": "PK",
    "PHL": "PH",
    "PCN": "PN",
    "POL": "PL",
    "SPM": "PM",
    "ZMB": "ZM",
    "ESH": "EH",
    "EST": "EE",
    "EGY": "EG",
    "ZAF": "ZA",
    "ECU": "EC",
    "ITA": "IT",
    "VNM": "VN",
    "SLB": "SB",
    "ETH": "ET",
    "SOM": "SO",
    "ZWE": "ZW",
    "SAU": "SA",
    "ESP": "ES",
    "ERI": "ER",
    "MNE": "ME",
    "MDA": "MD",
    "MDG": "MG",
    "MAF": "MF",
    "MAR": "MA",
    "MCO": "MC",
    "UZB": "UZ",
    "MMR": "MM",
    "MLI": "ML",
    "MAC": "MO",
    "MNG": "MN",
    "MHL": "MH",
    "MKD": "MK",
    "MUS": "MU",
    "MLT": "MT",
    "MWI": "MW",
    "MDV": "MV",
    "MTQ": "MQ",
    "MNP": "MP",
    "MSR": "MS",
    "MRT": "MR",
    "IMN": "IM",
    "UGA": "UG",
    "TZA": "TZ",
    "MYS": "MY",
    "MEX": "MX",
    "ISR": "IL",
    "FRA": "FR",
    "IOT": "IO",
    "SHN": "SH",
    "FIN": "FI",
    "FJI": "FJ",
    "FLK": "FK",
    "FSM": "FM",
    "FRO": "FO",
    "NIC": "NI",
    "NLD": "NL",
    "NOR": "NO",
    "NAM": "NA",
    "VUT": "VU",
    "NCL": "NC",
    "NER": "NE",
    "NFK": "NF",
    "NGA": "NG",
    "NZL": "NZ",
    "NPL": "NP",
    "NRU": "NR",
    "NIU": "NU",
    "COK": "CK",
    "XKX": "XK",
    "CIV": "CI",
    "CHE": "CH",
    "COL": "CO",
    "CHN": "CN",
    "CMR": "CM",
    "CHL": "CL",
    "CCK": "CC",
    "CAN": "CA",
    "COG": "CG",
    "CAF": "CF",
    "COD": "CD",
    "CZE": "CZ",
    "CYP": "CY",
    "CXR": "CX",
    "CRI": "CR",
    "CUW": "CW",
    "CPV": "CV",
    "CUB": "CU",
    "SWZ": "SZ",
    "SYR": "SY",
    "SXM": "SX",
    "KGZ": "KG",
    "KEN": "KE",
    "SSD": "SS",
    "SUR": "SR",
    "KIR": "KI",
    "KHM": "KH",
    "KNA": "KN",
    "COM": "KM",
    "STP": "ST",
    "SVK": "SK",
    "KOR": "KR",
    "SVN": "SI",
    "PRK": "KP",
    "KWT": "KW",
    "SEN": "SN",
    "SMR": "SM",
    "SLE": "SL",
    "SYC": "SC",
    "KAZ": "KZ",
    "CYM": "KY",
    "SGP": "SG",
    "SWE": "SE",
    "SDN": "SD",
    "DOM": "DO",
    "DMA": "DM",
    "DJI": "DJ",
    "DNK": "DK",
    "VGB": "VG",
    "DEU": "DE",
    "YEM": "YE",
    "DZA": "DZ",
    "USA": "US",
    "URY": "UY",
    "MYT": "YT",
    "UMI": "UM",
    "LBN": "LB",
    "LCA": "LC",
    "LAO": "LA",
    "TUV": "TV",
    "TWN": "TW",
    "TTO": "TT",
    "TUR": "TR",
    "LKA": "LK",
    "LIE": "LI",
    "LVA": "LV",
    "TON": "TO",
    "LTU": "LT",
    "LUX": "LU",
    "LBR": "LR",
    "LSO": "LS",
    "THA": "TH",
    "ATF": "TF",
    "TGO": "TG",
    "TCD": "TD",
    "TCA": "TC",
    "LBY": "LY",
    "VAT": "VA",
    "VCT": "VC",
    "ARE": "AE",
    "AND": "AD",
    "ATG": "AG",
    "AFG": "AF",
    "AIA": "AI",
    "VIR": "VI",
    "ISL": "IS",
    "IRN": "IR",
    "ARM": "AM",
    "ALB": "AL",
    "AGO": "AO",
    "ATA": "AQ",
    "ASM": "AS",
    "ARG": "AR",
    "AUS": "AU",
    "AUT": "AT",
    "ABW": "AW",
    "IND": "IN",
    "ALA": "AX",
    "AZE": "AZ",
    "IRL": "IE",
    "IDN": "ID",
    "UKR": "UA",
    "QAT": "QA",
    "MOZ": "MZ"
  };

  static String getMimeType(String filePath) {
    return lookupMimeType(filePath) ?? 'application/octet-stream';
  }

// ✅ Function to Request Storage Permission
// Function to request storage permission and guide the user to settings if denied
//   static Future<bool> _requestStoragePermission() async {
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       status = await Permission.storage.request();
//     }
//
//     if (status.isDenied || status.isPermanentlyDenied) {
//       print("❌ Storage permission denied");
//       // Open app settings if permanently denied
//       openAppSettings();
//     }
//     return status.isGranted;
//   }

  static Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;

      if (status.isDenied) {
        status = await Permission.storage.request();
      }

      if (status.isPermanentlyDenied) {
        print("❌ Storage permission permanently denied. Opening settings...");
        openAppSettings();
        return false;
      }

      if (status.isGranted) {
        return true;
      }

      // 🔹 Android 11+ requires MANAGE_EXTERNAL_STORAGE
      if (await Permission.manageExternalStorage.isDenied) {
        var manageStatus = await Permission.manageExternalStorage.request();
        if (!manageStatus.isGranted) {
          print("❌ Manage External Storage permission denied");
          return false;
        }
      }

      return Permission.manageExternalStorage.isGranted;
    }
    return true; // iOS doesn't need extra permissions
  }

  static bool _isOpeningFile = false;

  static Future<void> saveFileToDownloads(Uint8List bytes, String fileName) async {
    if (_isOpeningFile) return; // Prevent duplicate execution
    _isOpeningFile = true;

    if (kIsWeb) {
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: bytes,
        mimeType: MimeType.microsoftExcel,
        ext: 'xlsx',
      );
    } else {
      Directory directory;

      if (Platform.isAndroid) {
        if (!await _requestStoragePermission()) {
          print("❌ Storage permission denied");
          _isOpeningFile = false;
          return;
        }
        directory = (await getExternalStorageDirectory())!;
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        _isOpeningFile = false;
        return;
      }

      String newPath = await _getUniqueFileName(directory.path, fileName);
      final file = File(newPath);
      await file.writeAsBytes(bytes, flush: true);
      print("✅ File saved at: $newPath");

      // // 🔹 Try opening the file only once
      // final result = await OpenFile.open(newPath);
      //
      // if (result.type == ResultType.error) {
      //   print("❌ No compatible app found. Redirecting to store...");
      //   _redirectToAppStore();
      // }
    }

    _isOpeningFile = false; // Reset flag after completion
  }


  /// Generates a unique filename if the file already exists
  static Future<String> _getUniqueFileName(String dirPath, String fileName) async {
    String baseName = fileName.replaceAll('.xlsx', '');
    String extension = '.xlsx';
    String filePath = "$dirPath/$fileName";
    int counter = 1;

    while (await File(filePath).exists()) {
      filePath = "$dirPath/${baseName}_$counter$extension";
      counter++;
    }
    return filePath;
  }

  /// Redirects user to download an Excel-compatible app
  static void _redirectToAppStore() async {
    String url = "";

    if (Platform.isAndroid) {
      url = "market://details?id=com.microsoft.office.excel"; // Play Store link for Microsoft Excel
    } else if (Platform.isIOS) {
      url = "https://apps.apple.com/app/microsoft-excel/id586683407"; // App Store link for Microsoft Excel
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("❌ Could not launch the store.");
    }
  }

  static Future<void> savePdfLocally(Uint8List bytes, String fileName) async {
    try {
      String filePath;

      if (Platform.isAndroid) {
        // 🔹 Android: Save to internal storage instead of Downloads
        final directory = await getApplicationDocumentsDirectory();
        filePath = "${directory.path}/$fileName";
      } else if (Platform.isIOS) {
        // 🔹 iOS: Save to Documents folder
        final directory = await getApplicationDocumentsDirectory();
        filePath = "${directory.path}/$fileName";
      } else {
        // 🔹 Other platforms: Default to application documents
        final directory = await getApplicationDocumentsDirectory();
        filePath = "${directory.path}/$fileName";
      }

      // Ensure a unique file name if needed
      filePath = await _getUniqueFilePath(filePath);

      // 🔹 Write the file
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      print("✅ PDF saved successfully at: $filePath");

      // 🔹 Open the file immediately
      final result = await OpenFile.open(filePath);

      if (result.type == ResultType.error) {
        print("❌ No compatible app found. Redirecting to store...");
        _redirectToAppStore();
      }

    } catch (e) {
      print("❌ Failed to save and open PDF: $e");
    }
  }


// Function to get a unique file path
  static Future<String> _getUniqueFilePath(String originalPath) async {
    File file = File(originalPath);
    String pathWithoutExtension = originalPath.replaceAll(RegExp(r'\.pdf$'), '');
    String extension = ".pdf";
    int count = 1;

    while (await file.exists()) {
      file = File("$pathWithoutExtension _$count$extension");
      count++;
    }

    return file.path;
  }



  static Future<void> initiateCashFreePayment(String orderId, String sessionId, void Function(String) verifyPayment, void Function(CFErrorResponse, String) onError) async{
    try{
      var session = CFSessionBuilder().setEnvironment(CFEnvironment.SANDBOX).setOrderId(orderId).setPaymentSessionId(sessionId).build();
      var cfWebCheckout = CFWebCheckoutPaymentBuilder().setSession(session).build();
      var cfPaymentGateway = CFPaymentGatewayService();
      cfPaymentGateway.setCallback(verifyPayment, onError);
      cfPaymentGateway.doPayment(cfWebCheckout);
    }catch(e){
      log(e.toString());
    }
  }



}

enum SnackBarPosition {
  top,
  bottom,
}
