# API Call Flow & Clean Architecture Guide

This project follows **Clean Architecture** to ensure separation of concerns and scalability. All API integrations must follow this pattern.

## Overview
The architecture is divided into three main layers:
1.  **Data Layer**: Handles data retrieval (API calls, local DB) and serialization.
2.  **Domain Layer**: Contains pure business logic and contracts (Entities, UseCases, Repository Interfaces).
3.  **Presentation Layer**: Handles UI and State Management (BLoC).

## Step-by-Step Implementation Flow

### 1. Define API Endpoints
- Add your API endpoints in `lib/core/api_endpoints/api_endpoints.dart`.

### 2. Domain Layer (The Contract)
Start here to define *what* the feature does.
1.  **Entity**: Create a pure Dart class representing the business object.
    ```dart
    class MyFeatureEntity {
      final String id;
      final String name;

      MyFeatureEntity({required this.id, required this.name});
    }
    ```
2.  **Repository Interface**: Define the abstract contract for data retrieval.
    - Return `Future<Either<Failure, MyFeatureEntity>>`.
    ```dart
    abstract class MyFeatureRepository {
      Future<Either<Failure, MyFeatureEntity>> getData(MyParams params);
    }
    ```
3.  **UseCase**: Implement the business logic for a specific action.
    - Should implement `UseCase<Type, Params>`.
    ```dart
    @lazySingleton
    @injectable
    class GetMyFeatureUseCase implements UseCase<MyFeatureEntity, MyParams> {
      final MyFeatureRepository repository;
      GetMyFeatureUseCase(this.repository);

      @override
      Future<Either<Failure, MyFeatureEntity>> call(MyParams params) async {
        return repository.getData(params);
      }
    }
    ```

### 3. Data Layer (The Implementation)
Implement *how* the data is fetched.
1.  **Model**: Create a class that extends your **Entity**.
    - **MUST** include `fromJson` factory for serialization.
    ```dart
    class MyFeatureModel extends MyFeatureEntity {
      MyFeatureModel({required String id, required String name})
          : super(id: id, name: name);

      factory MyFeatureModel.fromJson(Map<String, dynamic> json) {
        return MyFeatureModel(
          id: json['id'],
          name: json['name'],
        );
      }
    }
    ```
2.  **DataSource**: Define the API call logic.
    - Use `NetworkClient` for requests.
    - Return `Model`.
    ```dart
    @LazySingleton(as: MyFeatureDataSource)
    @injectable
    class MyFeatureDataSourceImpl implements MyFeatureDataSource {
      final NetworkClient client;
      MyFeatureDataSourceImpl(this.client);

      @override
      Future<MyFeatureModel> getData(MyParams params) async {
        try {
          final response = await client.get(path: "/my-feature");
          return MyFeatureModel.fromJson(response.data);
        } catch (e) {
          rethrow;
        }
      }
    }
    ```
3.  **Repository Implementation**: Implement the Domain Repository interface.
    - Call the DataSource.
    - Map exceptions to `Failure`.
    - Return `Either<Failure, Entity>`.
    ```dart
    @LazySingleton(as: MyFeatureRepository)
    @injectable
    class MyFeatureRepoImpl implements MyFeatureRepository {
      final MyFeatureDataSource dataSource;
      MyFeatureRepoImpl(this.dataSource);

      @override
      Future<Either<Failure, MyFeatureEntity>> getData(MyParams params) async {
        try {
          final result = await dataSource.getData(params);
          return Right(result);
        } on CustomException catch (e) {
          return Left(Failure.apiRequestFailure(e.message));
        }
      }
    }
    ```

### 4. Presentation Layer (The UI)
Manage state and user interaction.
1.  **BLoC**: Create a BLoC to handle events and emit states.
    - Inject the UseCase.
    ```dart
    @injectable
    class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
      final GetMyFeatureUseCase useCase;

      MyFeatureBloc(this.useCase) : super(MyFeatureState.initial()) {
        on<GetDataEvent>((event, emit) async {
            // ... implementation
        });
      }
    }
    ```
2.  **Events & States**:
    - **MUST** use `freezed` for code generation.
    - **State** class **MUST** be a `sealed class`.
    - **DO NOT** use `equatable`.

    **Generic Event Structure**:
    ```dart
    part of 'my_feature_bloc.dart';

    @freezed
    class MyFeatureEvent with _$MyFeatureEvent {
      const factory MyFeatureEvent.getData() = GetData;
    }
    ```

    **Generic State Structure**:
    ```dart
    part of 'my_feature_bloc.dart';

    @freezed
    sealed class MyFeatureState with _$MyFeatureState {
      const factory MyFeatureState({
        required bool isLoading,
        String? error,
        MyFeatureEntity? data,
      }) = _Initial;

      factory MyFeatureState.initial() => const MyFeatureState(isLoading: false);
    }
    ```
3.  **Dependency Injection**:
    - Update `lib/app.dart` to provide the new BLoC using `MultiBlocProvider`.
    - Ensure your classes are annotated with `@injectable` or `@lazySingleton`.

## Dependency Injection & Code Generation
- Use `easy_init_cli` structure.
- Run the build runner to generate code (Freezed, JSON serialization, DI):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
    *(Or use the `easy build` command if available)*
