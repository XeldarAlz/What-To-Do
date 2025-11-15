import 'dart:math';

class MessageRepository {
  MessageRepository() : _pool = [] {
    _resetPool();
  }

  final _random = Random();
  late List<String> _pool;

  final List<String> _messages = const [
    'Harika bir fikir bulduk!',
    'Mükemmel bir seçenek!',
    'Sana özel bir önerimiz var!',
    'Bugün için harika bir plan!',
    'İşte senin için bir fikir!',
    'Muhteşem bir aktivite bulduk!',
    'Senin için özel bir öneri!',
    'Harika bir seçim yaptık!',
    'Bugün için mükemmel bir fikir!',
    'Sana özel bir aktivite!',
    'İlham verici bir öneri!',
    'Eğlenceli bir seçenek bulduk!',
  ];

  String get nextMessage {
    if (_pool.isEmpty) {
      _resetPool();
    }
    return _pool.removeLast();
  }

  void _resetPool() {
    _pool = List<String>.from(_messages)..shuffle(_random);
  }

  List<String> get messages => List.unmodifiable(_messages);
}
