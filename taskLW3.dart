/*class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  }) {}
}
  class Library{
  List<Book> _books=[];
  void addBook(Book book){
  _books.add(book);
  }
  List<Book>getAvaleblBooks(){
  return _books.where((book)=>book.isBorrowed==false).toList();
  }
  double getTotalValue(int sum, String book){
    return _books.fold(0.0, (sum, book)=>sum+book.price);
  }
  }
void main(){
  var librory=Library();
  librory.addBook(Book(title: "Harry Poter", author: "Me", price: 1200));
  librory.addBook(Book(title: "Endhous", author: "агата кристи", price: 3000, isBorrowed: false));
  librory.addBook(Book(title: "Сумерки", author: "Не знаю", price: 5200));
  print("Books: ");
  for(var book in librory.getAvaleblBooks()){
    print("${book.title}: ${book.price}");
  }
}

 */

abstract class MediaItem{
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
});
    String getDetails();
}
mixin Downloadable{
  void download(String title){
    print("Downloding: $title");
  }
}
class Audiobook extends MediaItem with Downloadable{
  double durationHours;
  String narrator;
  Audiobook({
    required String id,
    required String title,
    required double price,
    required this.durationHours,
    required this.narrator,
}):super(id: id, title: title,price: price);
  @override
  String getDetails() {
    return "Audiobook: $title ID:$id - $durationHours, $narrator Price: $price";
  }
}
class EBook extends MediaItem with Downloadable{
  double fileSixeMB;
  String author;
  EBook({
    required String id,
    required String title,
    required double price,
    required this.author,
    required this.fileSixeMB,
}):super(id: id,title: title,price: price);
  @override
  String getDetails() {
    return "EBook: $title $author $fileSixeMB price: $price, ";
  }
}

class ShopingCard {
  final List<MediaItem> _item = [];
  void addItem(MediaItem item){
    _item.add(item);
  }
  double calculateTotalWithTax({double textRate=0.12}){
    double subtotal=_item.fold(0.0, (sum, item)=>sum+item.price);
    return subtotal* (1+textRate);
  }
  List<MediaItem> filterByMaxPrice(double maxPrice){
    return _item.where((item)=>item.price<=maxPrice).toList();
  }
  void printReceipt(){
    for(var item in _item){
      print(item.getDetails());
      if (item is Downloadable){
        (item as Downloadable).download(item.title);
      }
    }
    double total=calculateTotalWithTax();
    print(total.toStringAsFixed(2));
  }
}
void main(){
  var card=ShopingCard();
  var Book1=EBook(id: "1", title: "rrr", price: 12233, author: "eqwe", fileSixeMB: 22.2);
  var AUBook2=Audiobook(id: "1", title: "edr", price: 1223, durationHours: 1, narrator: "dwe");
  card.addItem(Book1);
  card.addItem(AUBook2);
  card.printReceipt();
}