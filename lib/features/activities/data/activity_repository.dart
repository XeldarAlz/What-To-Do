import 'dart:math';

import 'package:what_to_do_app/features/activities/models/activity.dart';

class ActivityRepository {
  ActivityRepository() : _pool = [] {
    _resetPool();
  }

  final _random = Random();
  late List<Activity> _pool;

  final List<Activity> _activities = const [
    Activity(
      label: 'Restoranda akşam yemeği',
      query: 'restoran',
      emoji: '🍽️',
      imageQuery: 'restaurant dinner',
    ),
    Activity(
      label: 'Kahve içmek',
      query: 'kahve',
      emoji: '☕',
      imageQuery: 'coffee shop',
    ),
    Activity(
      label: 'Ata binme deneyimi',
      query: 'at binme',
      emoji: '🐎',
      imageQuery: 'horse riding',
    ),
    Activity(
      label: 'Ormanda yürüyüş',
      query: 'orman yürüyüş parkuru',
      emoji: '🌲',
      imageQuery: 'forest hiking',
    ),
    Activity(
      label: 'Sinema gecesi',
      query: 'sinema',
      emoji: '🎬',
      imageQuery: 'cinema movie',
    ),
    Activity(
      label: 'Canlı müzik',
      query: 'canlı müzik',
      emoji: '🎶',
      imageQuery: 'live music concert',
    ),
    Activity(
      label: 'Stand-up gösterisi',
      query: 'stand up',
      emoji: '🎤',
      imageQuery: 'standup comedy',
    ),
    Activity(
      label: 'Kamp veya piknik',
      query: 'piknik alanı',
      emoji: '🏕️',
      imageQuery: 'camping picnic',
    ),
    Activity(
      label: 'Spa & masaj',
      query: 'spa',
      emoji: '💆',
      imageQuery: 'spa massage',
    ),
    Activity(
      label: 'Rooftop bar',
      query: 'rooftop bar',
      emoji: '🍸',
      imageQuery: 'rooftop bar',
    ),
    Activity(
      label: 'Kaçış odası macerası',
      query: 'kaçış odası',
      emoji: '🕵️',
      imageQuery: 'escape room',
    ),
    Activity(
      label: 'Bowling turnuvası',
      query: 'bowling salonu',
      emoji: '🎳',
      imageQuery: 'bowling',
    ),
    Activity(
      label: 'Karaoke gecesi',
      query: 'karaoke bar',
      emoji: '🎤',
      imageQuery: 'karaoke',
    ),
    Activity(
      label: 'Gurme yemek workshopu',
      query: 'yemek workshop',
      emoji: '👩‍🍳',
      imageQuery: 'cooking class',
    ),
    Activity(
      label: 'Şarap tadımı',
      query: 'şarap tadım evi',
      emoji: '🍷',
      imageQuery: 'wine tasting',
    ),
    Activity(
      label: 'Sanat atölyesi',
      query: 'seramik atölyesi',
      emoji: '🎨',
      imageQuery: 'art workshop pottery',
    ),
    Activity(
      label: 'Şehir bisiklet turu',
      query: 'bisiklet kiralama',
      emoji: '🚴',
      imageQuery: 'bicycle city tour',
    ),
    Activity(
      label: 'Gönüllü etkinliği',
      query: 'gönüllülük merkezi',
      emoji: '🤝',
      imageQuery: 'volunteer community',
    ),
    Activity(
      label: 'Masa oyunu kafesi',
      query: 'board game cafe',
      emoji: '🎲',
      imageQuery: 'board game cafe',
    ),
    Activity(
      label: 'Go-kart yarışı',
      query: 'go kart pisti',
      emoji: '🏎️',
      imageQuery: 'go kart racing',
    ),
    Activity(
      label: 'Laser tag savaş',
      query: 'laser tag arena',
      emoji: '🔫',
      imageQuery: 'laser tag',
    ),
    Activity(
      label: 'Paintball maçı',
      query: 'paintball sahası',
      emoji: '🎯',
      imageQuery: 'paintball',
    ),
    Activity(
      label: 'VR oyun deneyimi',
      query: 'vr oyun salonu',
      emoji: '🕶️',
      imageQuery: 'virtual reality gaming',
    ),
    Activity(
      label: 'Tenis maçı',
      query: 'tenis kortu',
      emoji: '🎾',
      imageQuery: 'tennis court',
    ),
    Activity(
      label: 'Masa tenisi turnuvası',
      query: 'masa tenisi salonu',
      emoji: '🏓',
      imageQuery: 'table tennis',
    ),
    Activity(
      label: 'Okçuluk denemesi',
      query: 'okçuluk merkezi',
      emoji: '🏹',
      imageQuery: 'archery range',
    ),
    Activity(
      label: 'Buz pateni',
      query: 'buz pisti',
      emoji: '⛸️',
      imageQuery: 'ice skating',
    ),
    Activity(
      label: 'Kapalı tırmanış duvarı',
      query: 'tırmanış duvarı',
      emoji: '🧗',
      imageQuery: 'indoor climbing wall',
    ),
    Activity(
      label: 'Kaykay veya scooter parkı',
      query: 'skate park',
      emoji: '🛹',
      imageQuery: 'skate park',
    ),
    Activity(
      label: 'Bilardo gecesi',
      query: 'bilardo salonu',
      emoji: '🎱',
      imageQuery: 'billiard pool club',
    ),
    Activity(
      label: 'Nargile & lounge',
      query: 'nargile kafe',
      emoji: '💨',
      imageQuery: 'shisha lounge',
    ),
    Activity(
      label: 'Gece manzara noktası',
      query: 'seyir tepesi',
      emoji: '🌃',
      imageQuery: 'city night viewpoint',
    ),
    Activity(
      label: 'Boğaz tekne turu',
      query: 'boğaz tekne turu',
      emoji: '⛵',
      imageQuery: 'boat tour',
    ),
    Activity(
      label: 'Fotoğraf gezisi',
      query: 'fotoğraf turu',
      emoji: '📸',
      imageQuery: 'photography walk',
    ),
    Activity(
      label: 'Bitki & terrarium workshopu',
      query: 'terrarium atölyesi',
      emoji: '🌿',
      imageQuery: 'terrarium workshop',
    ),
    Activity(
      label: 'Puzzle kahve buluşması',
      query: 'puzzle kafe',
      emoji: '🧩',
      imageQuery: 'puzzle cafe',
    ),
    Activity(
      label: 'Kitapçılarda dolaşma',
      query: 'kitap evi',
      emoji: '📚',
      imageQuery: 'bookstore date',
    ),
    Activity(
      label: 'Yoga veya meditasyon dersi',
      query: 'yoga stüdyosu',
      emoji: '🧘',
      imageQuery: 'yoga studio',
    ),
    Activity(
      label: 'Hayvan barınağı ziyareti',
      query: 'hayvan barınağı',
      emoji: '🐶',
      imageQuery: 'animal shelter volunteering',
    ),
    Activity(
      label: 'Açık hava film gösterimi',
      query: 'açık hava sineması',
      emoji: '🎥',
      imageQuery: 'outdoor cinema',
    ),
    Activity(
      label: 'Sahilde gün batımı',
      query: 'sahil yürüyüş yolu',
      emoji: '🌅',
      imageQuery: 'sunset beach date',
    ),
    Activity(
      label: 'Atari turnuvası',
      query: 'retro oyun salonu',
      emoji: '🕹️',
      imageQuery: 'arcade gaming',
    ),
    Activity(
      label: 'Sabah koşusu',
      query: 'koşu parkuru',
      emoji: '🏃',
      imageQuery: 'morning jogging',
    ),
    Activity(
      label: 'Piknikte mangal',
      query: 'mangal alanı',
      emoji: '🍖',
      imageQuery: 'bbq picnic',
    ),
    Activity(
      label: 'Tarihi müze gezisi',
      query: 'tarih müzesi',
      emoji: '🏛️',
      imageQuery: 'history museum',
    ),
    Activity(
      label: 'Akvaryum ziyareti',
      query: 'akvaryum',
      emoji: '🐠',
      imageQuery: 'aquarium visit',
    ),
    Activity(
      label: 'Trambolin parkı',
      query: 'trambolin parkı',
      emoji: '🤸',
      imageQuery: 'trampoline park',
    ),
    Activity(
      label: 'Yelken eğitimi',
      query: 'yelken kulübü',
      emoji: '⛵',
      imageQuery: 'sailing lesson',
    ),
    Activity(
      label: 'Balık tutma',
      query: 'balık tutma alanı',
      emoji: '🎣',
      imageQuery: 'fishing outdoor',
    ),
    Activity(
      label: 'Sahil bisiklet turu',
      query: 'sahil bisiklet yolu',
      emoji: '🚴‍♂️',
      imageQuery: 'seaside cycling',
    ),
    Activity(
      label: 'Dans dersi',
      query: 'dans kursu',
      emoji: '💃',
      imageQuery: 'dance class couple',
    ),
    Activity(
      label: 'High rope park',
      query: 'macera parkı',
      emoji: '🧗‍♂️',
      imageQuery: 'high rope adventure park',
    ),
    Activity(
      label: 'Dilek feneri uçurma',
      query: 'sahil',
      emoji: '🏮',
      imageQuery: 'sky lantern beach',
    ),
    Activity(
      label: 'Kürek sporları',
      query: 'kürek kulübü',
      emoji: '🚣',
      imageQuery: 'rowing sport',
    ),
    Activity(
      label: 'Doğa fotoğrafçılığı',
      query: 'doğa parkı',
      emoji: '🌄',
      imageQuery: 'nature photography trip',
    ),
    Activity(
      label: 'Sokak lezzetleri turu',
      query: 'street food',
      emoji: '🌯',
      imageQuery: 'street food tour',
    ),
    Activity(
      label: 'Kayalık tırmanışı',
      query: 'kaya tırmanışı',
      emoji: '🪨',
      imageQuery: 'rock climbing outdoor',
    ),
    Activity(
      label: 'Sabah yoga seansı',
      query: 'yoga alanı',
      emoji: '🌞',
      imageQuery: 'morning yoga outdoor',
    ),
    Activity(
      label: 'Kutu oyun maratonu',
      query: 'board game cafe',
      emoji: '🎲',
      imageQuery: 'board game marathon',
    ),
  ];

  Activity get nextActivity {
    if (_pool.isEmpty) {
      _resetPool();
    }
    return _pool.removeLast();
  }

  void _resetPool() {
    _pool = List<Activity>.from(_activities)..shuffle(_random);
  }

  List<Activity> get activities => List.unmodifiable(_activities);
}
