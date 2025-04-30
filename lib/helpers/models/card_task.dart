class CardTask {
  final int id;
  final String title;
  final String description;
  final int priority;
  final String dueDate;

  CardTask(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.dueDate});

  // Método para convertir QueryRow a CardTask
  factory CardTask.fromMap(Map<String, dynamic> map) {
    return CardTask(
        id: map['id'] as int, // Asegúrate de que el campo exista
        title: map['title'] as String,
        description: map['description'] as String,
        priority: map['priority'] as int,
        dueDate: map['dueDate'] as String);
  }
}
