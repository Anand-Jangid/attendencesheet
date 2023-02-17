class AddExpenseModel{
  final String projectName;
  final String projectAmount;
  final String projectInvoice;
  final String expenseDescription;
  final String expenseType;
  final String date;
  final String Id;
  final List attachment;

  AddExpenseModel({
    required this.date,
    required this.projectName,
    required this.expenseType,
    required this.expenseDescription,
    required this.projectAmount,
    required this.projectInvoice,
    required this.Id,
    required this.attachment
});
}