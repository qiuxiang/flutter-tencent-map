import 'pigeon.g.dart';

final _api = TencentMapSdkApi();

void initTencentMapSdk({String iosApiKey = ''}) {
  _api.initSdk(iosApiKey);
}
