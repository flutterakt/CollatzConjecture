class Calculate {
  int i = 0;
  Map<int, int> maps = {};
  List<int> numbers = [];

  List<int>? produce(var controller) {
    //  print('Lütfen başlangıç değerini giriniz.');

    calculate(int.parse(controller.text));
//    print('${i + 1} . aşamada 1 sayısına ulaştınız.');

    // print(maps.values);
    return maps.values.toList();
  }

  void calculate(int initialValue) {
    i++;
    if (initialValue.isEven) {
      maps[i] = initialValue;
      initialValue = initialValue ~/ 2;
      if (initialValue != 1) {
        calculate(initialValue);

        return;
      }
    }
    if (initialValue.isOdd) {
      if (initialValue != 1) {
        maps[i] = initialValue;
        initialValue = 3 * initialValue + 1;
        calculate(initialValue);
      } else {
        maps[i + 1] = 1;
      }
    }
  }
}
