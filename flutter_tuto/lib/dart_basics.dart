//Dart pad: https://dartpad.dev/
//Dart cheat sheet: https://dart.dev/guides/language/cheatsheet

void main() {
  for(int i = 0; i < 5; i++) {
    print("hello ${i + 1}");
  }
  print(addNumbers(5,8.6, 7, 2.4));
  var test = MyClass("hey", 28);
  print(test.name);
  print(foo(text1:"hey", text2:"ma"));
}

num addNumbers(int a, double b, num c, num d) {
  return a + b + c;
}

String foo({String text1, String text2}) {
  return text1 + "foo" + text2;
}

class MyClass {
  String name = "Vincent";
  int age = 27;
  MyClass(this.name, this.age);
}