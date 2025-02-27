import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_bloc.dart'; // Импортируем BLoC

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }
          if (state is FavoritesLoaded) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(child: Text('Список избранного пуст'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return ListTile(
                  title: Text(favorite['title']),
                  subtitle: Text(favorite['author']),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}