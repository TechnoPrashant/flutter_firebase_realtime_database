class GetContactBean {
  String fullname;
  String emailAddress;
  String phoneNumber;
  bool isfav;
  String keyID;

  GetContactBean.name(this.fullname, this.emailAddress, this.phoneNumber,
      this.isfav, this.keyID);

  GetContactBean(this.fullname, this.emailAddress, this.phoneNumber, this.isfav,
      this.keyID);
}
