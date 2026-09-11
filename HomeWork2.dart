void checkBalance({required String name, required double balance})=> print('$name, $balance');
double deposit({required double carrentBalance, double? amount}){
  double upBalance=carrentBalance+(amount??0.0);
  return upBalance;
}
double withdrow({required String name, required double currentBalance, int? pinCod, double? amount}){
  int code=pinCod??0000;
  if(code!=1234){
    print('error');
    return currentBalance;
  }
  double aAmount=amount??0.0;
  if(aAmount>currentBalance){
    print('error');
    return currentBalance;
  }
  double newBalance=currentBalance-aAmount;
  print('your new balance: $newBalance');
  return newBalance;
}
void main(){
  double myBalance=1000.0;
  deposit(carrentBalance: myBalance, amount: 25.0);
  myBalance=withdrow(name: 'damir', currentBalance: myBalance, amount: 0.0, pinCod: 1234);
}