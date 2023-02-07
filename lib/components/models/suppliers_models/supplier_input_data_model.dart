class SupplierInputDataModel {
  String? supplierName;
  String? supplierNumber;
  String? vatId;
  String? url;
  String? fax;
  String? type;
  String? phone;
  String? supplierType;
  int? termsOfPayment;
  String? addressFirst;
  String? addressSecond;
  String? city;
  String? zip;
  String? state;
  String? country;

  SupplierInputDataModel(
      {this.supplierName,
      this.type,
      this.fax,
      this.zip,
      this.city,
      this.phone,
      this.vatId,
      this.state,
      this.country,
      this.addressSecond,
      this.addressFirst,
      this.url,
      this.termsOfPayment,
      this.supplierNumber,
      this.supplierType});
}
