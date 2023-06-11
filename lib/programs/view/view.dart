import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfocus/programs/bloc/programs_bloc.dart';
import 'package:stayfocus/repository/repository.dart';
import 'package:stayfocus/api/models/models.dart';

class ProgramsView extends StatefulWidget {
  final Repository repository;

  ProgramsView({Key? key, required this.repository}) : super(key: key);

  @override
  _ProgramsViewState createState() => _ProgramsViewState();
}

class _ProgramsViewState extends State<ProgramsView> {
  late ProgramsBloc _programsBloc;
  late TextEditingController _searchController;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _programsBloc = ProgramsBloc(repository: widget.repository)..add(LoadPrograms());
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _programsBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Programs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocProvider(
        create: (context) => _programsBloc,
        child: BlocBuilder<ProgramsBloc, ProgramsState>(
          builder: (context, state) {
            if (state is ProgramsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProgramsLoaded) {
              final programs = _filterPrograms(state.programs);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: programs.length,
                      itemBuilder: (context, index) {
                        final program = programs[index];

                        return ListTile(
                          title: Text(program.name),
                          // Ajoutez d'autres widgets pour afficher les détails du programme si nécessaire
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProgramsError) {
              return Center(
                child: Text('An error occurred: ${state.error}'),
              );
            }

            return const Center(
              child: Text('Programs Page'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _buildAddProgramDialog(context),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Program> _filterPrograms(List<Program> programs) {
    if (_searchText.isEmpty) {
      return programs;
    }

    final searchQuery = _searchText.toLowerCase();
    return programs.where((program) => program.name.toLowerCase().contains(searchQuery)).toList();
  }

    Widget _buildAddProgramDialog(BuildContext context) {
      return Container();
    }
}
