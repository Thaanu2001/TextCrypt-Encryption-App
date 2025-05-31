class SaveText {
  final int? id;
  final String text;
  final String description;

  SaveText({
    this.id,
    required this.text,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'SaveText{id: $id, text: $text, description: $description}';
  }

  factory SaveText.fromMap(Map<String, dynamic> map) {
    return SaveText(
      id: map['id'] as int,
      text: map['text'] as String,
      description: map['description'] as String,
    );
  }
}
