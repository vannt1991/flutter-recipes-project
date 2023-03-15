import 'package:flutter/material.dart';

import '../../l10n/gen/app_localizations.dart';
import '../domain/entities/recipe_entity.dart';
import '../core/widgets/index.dart' as core_widgets;

class DetailScreen extends StatefulWidget {
  final RecipeEntity recipe;
  const DetailScreen({super.key, required this.recipe});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.recipe.name ?? '--'),
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: core_widgets.ImageHandlerWidget(
                  urlToImage: widget.recipe.image ?? '',
                ),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black54,
                  ),
                  child: Text(
                    widget.recipe.time ?? '--',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.recipe.description ?? '--',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.ingredients,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                InfoRowWidget(
                    name: AppLocalizations.of(context)!.calories,
                    value: widget.recipe.calories ?? '--'),
                InfoRowWidget(
                    name: AppLocalizations.of(context)!.proteins,
                    value: widget.recipe.proteins ?? '--'),
                InfoRowWidget(
                    name: AppLocalizations.of(context)!.fats,
                    value: widget.recipe.fats ?? '--'),
                InfoRowWidget(
                    name: AppLocalizations.of(context)!.carbos,
                    value: widget.recipe.carbos ?? '--'),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class InfoRowWidget extends StatelessWidget {
  final String name;
  final String value;
  const InfoRowWidget({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
