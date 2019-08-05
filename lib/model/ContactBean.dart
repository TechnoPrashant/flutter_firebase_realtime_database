class ContactBean {
  String fullname;
  String emailAddress;
  String phoneNumber;
  bool isfav;

  ContactBean.name(
      this.fullname, this.emailAddress, this.phoneNumber, this.isfav);

  ContactBean(this.fullname, this.emailAddress, this.phoneNumber, this.isfav);
}
