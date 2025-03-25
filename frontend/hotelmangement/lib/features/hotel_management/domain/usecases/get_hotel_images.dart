import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class GetHotelImages extends Usecase<List<String>, Params> {
  final HotelRepository repository;

  GetHotelImages({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(Params params) {
    return repository.getHotelImages(params.imageNames);
  }
}

class Params extends Equatable {
  final List<String> imageNames;

  const Params({required this.imageNames});

  @override
  List<Object?> get props => [imageNames];
}
