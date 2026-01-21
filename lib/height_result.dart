// File: lib/height_result.dart

class HeightResult {
  final String status;
  final double confidence;
  final String? imageUrl;       // URL Foto dari server
  final List<double> probabilities; // List probabilitas

  HeightResult({
    required this.status,
    required this.confidence,
    this.imageUrl,
    required this.probabilities,
  });

  factory HeightResult.fromMap(Map<String, dynamic> json) {
    // [FIX] Menggunakan List<double>.from agar tipe datanya tegas dan tidak error
    List<double> parseProbs(dynamic val) {
      if (val is List) {
        // Kita paksa konversi setiap item jadi double, lalu bungkus jadi List<double>
        return List<double>.from(val.map((e) => (e ?? 0.0).toDouble()));
      }
      return [];
    }

    return HeightResult(
      // 1. Status / Label
      status: json['label']?.toString() ?? 'Unknown',

      // 2. Confidence / Akurasi
      confidence: (json['confidence'] ?? 0.0).toDouble(),

      // 3. Foto URL
      imageUrl: json['photo_url'],

      // 4. Probabilitas
      probabilities: parseProbs(json['prediction']),
    );
  }
}