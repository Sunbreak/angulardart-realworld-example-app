import 'package:angular/angular.dart';
import 'package:markdown/markdown.dart';

@Pipe('markdown')
class MarkdownPipe extends PipeTransform {
  String transform(String content) {
    return markdownToHtml(content);
  }
}
