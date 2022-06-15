import 'pigeon.g.dart';

final _api = MarkerApi();

class Marker {
  final String id;

  const Marker(this.id);

  void remove() => _api.remove(id);
}
