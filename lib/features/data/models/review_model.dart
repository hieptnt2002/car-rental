import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/data/models/user_model.dart';
import 'package:car_rental/features/domain/entities/review.dart';

class ReviewModel with EntityConvertable<ReviewModel, Review> {
  final int id;
  final double score;
  final String comment;
  final int like;
  final int dislike;
  final UserModel user;
  final DateTime createdAt;
  ReviewModel({
    required this.id,
    required this.score,
    required this.comment,
    required this.like,
    required this.dislike,
    required this.user,
    required this.createdAt,
  });
  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] as int,
      score: map['score'] as double,
      comment: map['comment'] as String,
      like: map['numberOfLike'],
      dislike: map['numberOfDislike'],
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(map['createAt']),
    );
  }

  @override
  Review toEntity() {
    return Review(
      id: id,
      score: score,
      comment: comment,
      like: like,
      dislike: dislike,
      user: user.toEntity(),
      createdAt: createdAt,
    );
  }
}
