import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';

class GetHotelImageAuthUrl extends Usecase<String, Params> {
  final FileRepository repository;

  GetHotelImageAuthUrl(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.getFileAuthUrl(params.imagePath, "hotelimage");
  }
}

class Params extends Equatable {
  final String imagePath;

  const Params({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}
