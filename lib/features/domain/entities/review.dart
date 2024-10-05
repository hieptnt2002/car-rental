import 'package:car_rental/features/domain/entities/user.dart';

class Review {
  final int id;
  final double score;
  final String comment;
  final int like;
  final int dislike;
  final User user;
  final DateTime createdAt;
  Review({
    required this.id,
    required this.score,
    required this.comment,
    required this.like,
    required this.dislike,
    required this.user,
    required this.createdAt,
  });
}
