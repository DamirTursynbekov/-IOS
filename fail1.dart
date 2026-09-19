/*1
double procOrder({
  required int orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFree,
}){
  double fdelivery= deliveryFree??500.0;
  if(fdelivery<500.0){
    fdelivery=500;
  }
  double discount = (promoCode=='SAVE10')?itemPrice*0.9:itemPrice;
  double total= fdelivery+discount;
  print('N:$orderId, price:$itemPrice, total=$total, dfree: $fdelivery');
  return total;
}

void main(){
  procOrder(orderId: 1, itemPrice: 10000, promoCode: 'SAVE10');
  procOrder(orderId: 1, itemPrice: 10000, promoCode: 'SAVE10', deliveryFree: 400);
}

 */

/*2
bool isLeapYear(int year){
  if(year%400==0 || (year%100==0 && year%4==0)){
    return true;
  }else {
    return false;
  }
}
int daysIsMonth(int month, int year){
  switch(month){
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      return 31;
    case 4:
    case 6:
    case 9:
    case 11:
      return 30;
    case 2:
      if(isLeapYear(year)){
        return 29;
      }else{
        return 28;
      }
    default:
      return 0;
  }
}
void main(){
  int day=31;
  int month=12;
  int year=2026;
  if(day<daysIsMonth(month, year)){
    day=day+1;
  }else if(month==12){
    day=1;
    month=1;
    year=year+1;
  }else{
    month=month+1;
  }
  print('$day, $month, $year');
}

 */

/*3
void main(){
  String word='souaiecdsd';
  int count=0;
  String vowels='aeiuo';
  for(int i=0; i< word.length;i++){
    if(vowels.contains(word[i])){
      count++;
    }
  }
  print('$count');
}

 */
/* 4
void main(){
  List<int> numbers=[32,4,12,66,91,3];
  int max=numbers[0];
  int min =numbers[0];
  for(int i=0;i<numbers.length;i++){
    if(max<numbers[i]){
      max=numbers[i];
    }
    if(min>numbers[i]){
      min=numbers[i];
    }
  }
  print('$min,$max');
}

 */
bool isPrime(int n){
  if(n<1) return false;
  for(int i=2; i<n;i++){
    if(n%i==0) return false;
  }
  return true;
}
void main(){
  int n=7;
  print(isPrime(n));
}