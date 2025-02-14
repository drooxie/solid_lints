part of '../newline_before_return_rule.dart';

/// A Quick fix for `newline_before_return` rule
/// Adding the missing newline before a return statement
class _NewlineBeforeReturnFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    if (analysisError.message != 'Missing blank line before return.') return;

    final changeBuilder = reporter.createChangeBuilder(
      message: 'Add a newline before return statement',
      priority: 1,
    );

    final location = resolver.lineInfo.getLocation(analysisError.offset);

    changeBuilder.addDartFileEdit(
      (builder) => builder.addInsertion(
        resolver.lineInfo.getOffsetOfLine(location.lineNumber - 1),
        (builder) => builder.writeln(),
      ),
    );
  }
}
