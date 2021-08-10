// import 'dart:convert';

// import 'package:ansi_logger/ansi_logger.dart';
// import 'package:dio/dio.dart';

// class MyInterceptor extends Interceptor {
//   final logger = AnsiLogger(name: "Dio", length: 100);

//   dynamic tryGetMap(dynamic data) {
//     try {
//       if (data is String)
//         return jsonDecode(data);
//       else
//         return data;
//     } catch (e) {
//       return data;
//     }
//   }

//   @override
//   Future onError(DioError err) async {
//     dynamic requestData;
//     List<IFile> files;
//     if (err.request.data is FormData) {
//       var fd = err.request.data as FormData;
//       requestData = {};
//       fd.fields.forEach((element) {
//         requestData[element.key] = element.value;
//       });
//       files = [];
//       for (var k in fd.files) {
//         files.add(IFile(k.value.filename, k.key, k.value.length));
//       }
//     } else
//       requestData = err.request.data;
//     logger.logHttp(
//       url: err.request.uri.toString(),
//       statusMessage: err.response?.statusMessage,
//       method: err.request.method,
//       statusCode: err.response.statusCode,
//       queryParameters: err.request.queryParameters,
//       requestHeaders: err.request.headers,
//       responseHeaders: {},
//       response: tryGetMap(err.response.data),
//       requestData: requestData,
//       files: files,
//     );
//   }

//   @override
//   Future onResponse(Response response) async {
//     dynamic requestData;
//     List<IFile> files;
//     if (response.request.data is FormData) {
//       var fd = response.request.data as FormData;
//       requestData = {};
//       fd.fields.forEach((element) {
//         requestData[element.key] = element.value;
//       });
//       files = [];
//       for (var k in fd.files) {
//         files.add(IFile(k.value.filename, k.key, k.value.length));
//       }
//     } else
//       requestData = response.request.data;
//     logger.logHttp(
//       url: response.request.uri.toString(),
//       statusMessage: response.statusMessage,
//       method: response.request.method,
//       statusCode: response.statusCode,
//       queryParameters: response.request.queryParameters,
//       requestHeaders: response.request.headers,
//       responseHeaders: {},
//       response: tryGetMap(response.data),
//       requestData: requestData,
//       files: files,
//     );
//   }
// }
