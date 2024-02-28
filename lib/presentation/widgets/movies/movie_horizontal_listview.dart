import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({super.key, required this.movies, this.title, this.subtitle, this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if (widget.loadNextPage == null) return;

      if (( scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent ) {
        widget.loadNextPage!();
      }
    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _Title(title: widget.title, subTitle: widget.subtitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _SlideMovie(movie: widget.movies[index],));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _SlideMovie extends StatelessWidget {

  final Movie movie;

  const _SlideMovie({required this.movie});

  @override
  Widget build(BuildContext context) {

    TextTheme textStyle =  Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/movie/${ movie.id }'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 170,
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  height: 160,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                      ? FadeIn(child: child)
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            // Title
            SizedBox(
              width: 150,
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textStyle.titleSmall
              ),
            ),
            // Rating
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(Icons.star, size: 15, color: Colors.yellow.shade800),
                  const SizedBox(width: 5),
                  Text(
                    '${ movie.voteAverage }',
                    style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),
                  ),
                  const Spacer(),
                  Text(
                    HumanFormats.number(movie.popularity), style: textStyle.bodySmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {

    TextTheme textStyle =  Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: textStyle.titleLarge,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact ),
              onPressed: () {},
              child: Text(subTitle!),
            ),
        ],
      ),
    );
  }
}