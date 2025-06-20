import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heron/core/network/request.dart';
import 'package:heron/core/network/result_data.dart';

final apiProvider = Provider<Api>((ref) => Api());

class Api {
  final request = Request();

  Future<ResultData<dynamic>> getConfig(Map<String, dynamic> data) {
    return request.post('/api/getConfig', data: data, extra: {"auth": false});
  }
}
