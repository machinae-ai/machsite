enum CellType { python, eval, gpt_text, gpt_code, get_page }

class _CellTypeInfo {
  final String name;

  const _CellTypeInfo({required this.name});
}

extension CellTypeExt on CellType {
  _CellTypeInfo get info {
    switch (this) {
      case CellType.python:
        return const _CellTypeInfo(name: 'Python');
      case CellType.eval:
        return const _CellTypeInfo(name: 'Eval');
      case CellType.gpt_text:
        return const _CellTypeInfo(name: 'GPT Text');
      case CellType.gpt_code:
        return const _CellTypeInfo(name: 'GPT Code');
      case CellType.get_page:
        return const _CellTypeInfo(name: 'Get Page');
      default:
        throw ArgumentError('Unknown fruit: $this');
    }
  }
}

getCellTypeByString(String cellTypeString) {
  return CellType.values
      .firstWhere((e) => e.toString().split('.').last == cellTypeString);
}
