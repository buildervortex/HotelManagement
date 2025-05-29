import 'package:get_it/get_it.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/dashboard_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_food_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_management_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_room_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_table_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/manager_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/dashboard_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/file_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_food_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_room_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/hotel_table_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/data/repositories/manager_repository_impl.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/manager_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_active_table_bookings.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_active_takeaway_bookings.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_famous_food_in_all_hotels.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_famous_foods_in_own_hotels.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_hotel_ratings.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/add_food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/create_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/delete_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/delete_food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_image_auth_url.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_images.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_foods_in_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/update_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/add_hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/add_hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/create_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_details.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_image_auth_url.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_images.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_phone_numbers.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/update_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/manager_sign_up.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/add_room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/create_room.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/delete_room.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/delete_room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_image_auth_url.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_images.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_rooms_in_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/update_room.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/create_table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/delete_table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/get_tables_in_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/update_table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_table_bookings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_takeaway_bookings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_famous_foods_in_all_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_hotel_ratings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_hotel_state_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_own_hotels_famous_foods_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// final gi = GetIt
final gi = GetIt.instance;

void setUpLocator() {
  // register the supabase client
  gi.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // register the data sources
  gi.registerLazySingleton<DashboardDataSource>(
      () => DashboardDataSourceImpl(client: gi<SupabaseClient>()));
  gi.registerLazySingleton<FileDataSource>(
      () => FileDataSourceImpl(client: gi<SupabaseClient>()));
  gi.registerLazySingleton<HotelFoodDataSource>(
      () => HotelFoodDataSourceImpl(client: gi<SupabaseClient>()));
  gi.registerLazySingleton<HotelManagementDataSource>(
      () => HotelManagementDataSourceImpl(client: gi<SupabaseClient>()));
  gi.registerLazySingleton<HotelRoomDataSource>(
      () => HotelRoomDataSourceImpl(client: gi<SupabaseClient>()));
  gi.registerLazySingleton<HotelTableDataSource>(
      () => HotelTableDataSourceImpl(client: gi<SupabaseClient>()));
  gi.registerLazySingleton<ManagerDataSource>(
      () => ManagerDataSourceImpl(client: gi<SupabaseClient>()));

  // register the repositories
  gi.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(dataSource: gi<DashboardDataSource>()));
  gi.registerLazySingleton<FileRepository>(
      () => FileRepositoryImpl(fileDataSource: gi<FileDataSource>()));
  gi.registerLazySingleton<HotelFoodRepository>(() => HotelFoodRepositoryImpl(
      dataSource: gi<HotelFoodDataSource>(),
      fileDataSource: gi<FileDataSource>()));
  gi.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl(
      dataSource: gi<HotelManagementDataSource>(),
      fileDataSource: gi<FileDataSource>()));
  gi.registerLazySingleton<HotelRoomRepository>(() => HotelRoomRepositoryImpl(
      dataSource: gi<HotelRoomDataSource>(),
      fileDataSource: gi<FileDataSource>()));
  gi.registerLazySingleton<HotelTableRepository>(
      () => HotelTableRepositoryImpl(dataSource: gi<HotelTableDataSource>()));
  gi.registerLazySingleton<ManagerRepository>(
      () => ManagerRepositoryImpl(dataSource: gi<ManagerDataSource>()));

  // register usecases
  gi.registerLazySingleton<HotelAuthorize>(
      () => HotelAuthorize(gi<HotelRepository>()));
  // register dashboard usecase
  gi.registerLazySingleton<GetActiveTableBookings>(
      () => GetActiveTableBookings(repository: gi<DashboardRepository>()));
  gi.registerLazySingleton<GetActiveTakeawayBookings>(
      () => GetActiveTakeawayBookings(repository: gi<DashboardRepository>()));
  gi.registerLazySingleton<GetFamousFoodInAllHotels>(
      () => GetFamousFoodInAllHotels(repository: gi<DashboardRepository>()));
  gi.registerLazySingleton<GetFamousFoodsInOwnHotels>(
      () => GetFamousFoodsInOwnHotels(repository: gi<DashboardRepository>()));
  gi.registerLazySingleton<GetHotelRatings>(
      () => GetHotelRatings(repository: gi<DashboardRepository>()));

  // reigster food usecase
  gi.registerLazySingleton<AddFoodImage>(() => AddFoodImage(
      repository: gi<HotelFoodRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<CreateFood>(() => CreateFood(
      repository: gi<HotelFoodRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<DeleteFood>(() => DeleteFood(
      repository: gi<HotelFoodRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<DeleteFoodImage>(() => DeleteFoodImage(
      repository: gi<HotelFoodRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<GetFoodImageAuthUrl>(
      () => GetFoodImageAuthUrl(repository: gi<FileRepository>()));
  gi.registerLazySingleton<GetFoodImages>(
      () => GetFoodImages(repository: gi<HotelFoodRepository>()));
  gi.registerLazySingleton<GetFoodsInHotel>(
      () => GetFoodsInHotel(repository: gi<HotelFoodRepository>()));
  gi.registerLazySingleton<UpdateFood>(() => UpdateFood(
      repository: gi<HotelFoodRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));

  // register hotel usecases
  gi.registerLazySingleton<AddHotelImage>(
      () => AddHotelImage(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<AddHotelPhoneNumber>(
      () => AddHotelPhoneNumber(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<CreateHotel>(
      () => CreateHotel(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<DeleteHotel>(
      () => DeleteHotel(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<DeleteHotelImage>(
      () => DeleteHotelImage(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<DeleteHotelPhoneNumber>(
      () => DeleteHotelPhoneNumber(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<GetHotelDetails>(
      () => GetHotelDetails(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<GetHotelImageAuthUrl>(
      () => GetHotelImageAuthUrl(gi<FileRepository>()));
  gi.registerLazySingleton<GetHotelImages>(
      () => GetHotelImages(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<GetHotelPhoneNumbers>(
      () => GetHotelPhoneNumbers(repository: gi<HotelRepository>()));
  gi.registerLazySingleton<UpdateHotel>(
      () => UpdateHotel(repository: gi<HotelRepository>()));

  // register manager usecases
  gi.registerLazySingleton<ManagerSignUp>(
      () => ManagerSignUp(repository: gi<ManagerRepository>()));

  // register room usecases
  gi.registerLazySingleton<AddRoomImage>(() => AddRoomImage(
      repository: gi<HotelRoomRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<CreateRoom>(
      () => CreateRoom(gi<HotelRoomRepository>()));
  gi.registerLazySingleton<DeleteRoom>(() => DeleteRoom(
      repository: gi<HotelRoomRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<DeleteRoomImage>(() => DeleteRoomImage(
      repository: gi<HotelRoomRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<GetRoomImageAuthUrl>(
      () => GetRoomImageAuthUrl(repository: gi<FileRepository>()));
  gi.registerLazySingleton<GetRoomImages>(
      () => GetRoomImages(repository: gi<HotelRoomRepository>()));
  gi.registerLazySingleton<GetRoomsInHotel>(
      () => GetRoomsInHotel(repository: gi<HotelRoomRepository>()));
  gi.registerLazySingleton<UpdateRoom>(
      () => UpdateRoom(gi<HotelRoomRepository>(), gi<HotelAuthorize>()));

  // register table usecases
  gi.registerLazySingleton<CreateTable>(() => CreateTable(
      repository: gi<HotelTableRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<DeleteTable>(() => DeleteTable(
      repository: gi<HotelTableRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));
  gi.registerLazySingleton<GetTablesInHotel>(
      () => GetTablesInHotel(repository: gi<HotelTableRepository>()));
  gi.registerLazySingleton<UpdateTable>(() => UpdateTable(
      repository: gi<HotelTableRepository>(),
      hotelAuthorize: gi<HotelAuthorize>()));

  // reigister blocks
  gi.registerFactory<GetActiveTableBookingsCubit>(
      () => GetActiveTableBookingsCubit(usecase: gi<GetActiveTableBookings>()));
  gi.registerFactory<GetActiveTakeawayBookingsCubit>(() =>
      GetActiveTakeawayBookingsCubit(usecase: gi<GetActiveTakeawayBookings>()));
  gi.registerFactory<GetFamousFoodsInAllCubit>(
      () => GetFamousFoodsInAllCubit(usecase: gi<GetFamousFoodInAllHotels>()));
  gi.registerFactory<GetHotelRatingsCubit>(() => gi<GetHotelRatingsCubit>());
  gi.registerFactory<GetHotelStateCubit>(() => gi<GetHotelStateCubit>());
  gi.registerFactory<GetOwnHotelsFamousFoodsCubit>(() =>
      GetOwnHotelsFamousFoodsCubit(usecase: gi<GetFamousFoodsInOwnHotels>()));
}
