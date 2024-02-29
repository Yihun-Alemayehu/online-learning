import 'package:equatable/equatable.dart';
import 'package:online_learning/core/res/media_files.dart';

class PageContent extends Equatable{
  final String image;
  final String title;
  final String description;

  PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  factory PageContent.first() {
    return PageContent(
      image: MediaFiles.casualReading,
      title: 'Brand New Curriculum',
      description:
          'This is the first online learning platform designed by the world\'s top professors',
    );
  }

  factory PageContent.second() {
    return PageContent(
      image: MediaFiles.casualLife,
      title: 'Brand a fun atmostphere',
      description:
          'This is the first online learning platform designed by the world\'s top professors',
    );
  }

  factory PageContent.third() {
    return PageContent(
      image: MediaFiles.casualMeditation,
      title: 'Easy to join ther lesson',
      description:
          'This is the first online learning platform designed by the world\'s top professors',
    );
  }
  
  @override
  List<Object?> get props => [image,title,description];
}
