/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/6/7 ÐÇÆÚËÄ ÉÏÎç 10:17:36                     */
/*==============================================================*/


drop table if exists Category;

drop table if exists CheckStock;

drop table if exists Customer;

drop table if exists POItem;

drop table if exists POMain;

drop table if exists Product;

drop table if exists SOItem;

drop table if exists SOMain;

drop table if exists ScmUser;

drop table if exists StockRecord;

drop table if exists SystemModel;

drop table if exists UserModel;

drop table if exists Vender;

drop table if exists payrecord;

/*==============================================================*/
/* Table: Category                                              */
/*==============================================================*/
create table Category
(
   CategoryID           int not null AUTO_INCREMENT,
   Name                 VARCHAR(20) not null,
   Remark               VARCHAR(200),
   primary key (CategoryID)
)
;

/*==============================================================*/
/* Table: CheckStock                                            */
/*==============================================================*/
create table CheckStock
(
   StockID              int not null AUTO_INCREMENT,
   ProductCode          VARCHAR(20),
   OriginNum            int,
   RealNum              int,
   StockTime            VARCHAR(20),
   CreateUser           VARCHAR(10),
   Description          VARCHAR(255),
   Type                 VARCHAR(10),
   primary key (StockID)
)
;

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table Customer
(
   CustomerCode         VARCHAR(20) not null,
   Name                 VARCHAR(100) not null,
   Password             VARCHAR(20) not null,
   Contactor            VARCHAR(10) not null,
   Address              VARCHAR(100) not null,
   Postcode             VARCHAR(8),
   Tel                  VARCHAR(20) not null,
   Fax                  VARCHAR(20),
   CreateDate           VARCHAR(20) not null,
   primary key (CustomerCode)
)
;

/*==============================================================*/
/* Table: POItem                                                */
/*==============================================================*/
create table POItem
(
   POID                 numeric(14,0) not null,
   ProductCode          VARCHAR(20) not null,
   UnitPrice            float not null,
   Num                  int not null,
   UnitName             VARCHAR(5) not null,
   ItemPrice            float not null,
   primary key (POID, ProductCode)
)
;

/*==============================================================*/
/* Table: POMain                                                */
/*==============================================================*/
create table POMain
(
   POID                 numeric(14,0) not null,
   VenderCode           VARCHAR(20),
   Account              VARCHAR(20),
   CreateTime           VARCHAR(20) not null,
   TipFee               float not null,
   ProductTotal         float not null,
   POTotal              float not null,
   PayType              int not null,
   PrePayFee            float not null,
   Status               int not null,
   Remark               VARCHAR(255),
   StockTime            VARCHAR(20),
   StockUser            VARCHAR(20),
   PayTime              VARCHAR(20),
   PayUser              VARCHAR(20),
   PrePayTime           VARCHAR(20),
   PrePayUser           VARCHAR(20),
   EndTime              VARCHAR(20),
   EndUser              VARCHAR(20),
   primary key (POID)
)
;

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
create table Product
(
   ProductCode          VARCHAR(20) not null,
   CategoryID           int,
   Name                 VARCHAR(50) not null,
   UnitName             VARCHAR(5) not null,
   Price                float not null,
   CreateDate           VARCHAR(20) not null,
   Remark               VARCHAR(255),
   num                  int,
   PONum                int not null,
   SONum                int not null,
   primary key (ProductCode)
)
;

/*==============================================================*/
/* Table: SOItem                                                */
/*==============================================================*/
create table SOItem
(
   SOID                 numeric(14,0) not null,
   ProductCode          VARCHAR(20) not null,
   UnitPrice            float not null,
   Num                  int not null,
   UnitName             VARCHAR(5) not null,
   ItemPrice            float not null,
   primary key (SOID, ProductCode)
)
;

/*==============================================================*/
/* Table: SOMain                                                */
/*==============================================================*/
create table SOMain
(
   SOID                 numeric(14,0) not null,
   CustomerCode         VARCHAR(20),
   Account              VARCHAR(20),
   CreateTime           VARCHAR(20) not null,
   TipFee               float not null,
   ProductTotal         float not null,
   POTotal              float not null,
   PayType              int not null,
   PrePayFee            float not null,
   Status               int not null,
   Remark               VARCHAR(255),
   StockTime            VARCHAR(20),
   StockUser            VARCHAR(20),
   PayTime              VARCHAR(20),
   PayUser              VARCHAR(20),
   PrePayTime           VARCHAR(20),
   PrePayUser           VARCHAR(20),
   EndTime              VARCHAR(20),
   EndUser              VARCHAR(20),
   primary key (SOID)
)
;

/*==============================================================*/
/* Table: ScmUser                                               */
/*==============================================================*/
create table ScmUser
(
   Account              VARCHAR(20) not null,
   Password             VARCHAR(20),
   Name                 VARCHAR(20),
   CreateDate           VARCHAR(20),
   Status               int,
   primary key (Account)
)
;

/*==============================================================*/
/* Table: StockRecord                                           */
/*==============================================================*/
create table StockRecord
(
   StockID              int not null AUTO_INCREMENT,
   ProductCode          VARCHAR(20),
   OrderCode            VARCHAR(20),
   StockNum             int not null,
   StockType            int not null,
   StockTime            VARCHAR(20) not null,
   CreateUser           VARCHAR(10) not null,
   primary key (StockID)
)
;

/*==============================================================*/
/* Table: SystemModel                                           */
/*==============================================================*/
create table SystemModel
(
   ModelCode            int not null AUTO_INCREMENT,
   ModelName            VARCHAR(20) not null,
   ModelUri             VARCHAR(64),
   primary key (ModelCode)
)
;

/*==============================================================*/
/* Table: UserModel                                             */
/*==============================================================*/
create table UserModel
(
   Account              VARCHAR(20) not null,
   ModelCode            int not null,
   primary key (Account, ModelCode)
)
;

/*==============================================================*/
/* Table: Vender                                                */
/*==============================================================*/
create table Vender
(
   VenderCode           VARCHAR(20) not null,
   Name                 VARCHAR(100) not null,
   Password             VARCHAR(20) not null,
   Contactor            VARCHAR(10) not null,
   Address              VARCHAR(100) not null,
   Postcode             VARCHAR(8),
   Tel                  VARCHAR(20) not null,
   Fax                  VARCHAR(20),
   CreateDate           VARCHAR(20) not null,
   primary key (VenderCode)
)
;

/*==============================================================*/
/* Table: payrecord                                             */
/*==============================================================*/
create table payrecord
(
   record_id            int not null AUTO_INCREMENT,
   pay_time             varchar(32),
   pay_price            decimal(12,2),
   account              varchar(32),
   ordercode            varchar(32),
   pay_type             int,
   primary key (record_id)
);

alter table CheckStock add constraint FK_C_S foreign key (ProductCode)
      references Product (ProductCode) on delete restrict on update restrict;

alter table POItem add constraint FK_PD_PM foreign key (POID)
      references POMain (POID) on delete restrict on update restrict;

alter table POItem add constraint FK_P_P foreign key (ProductCode)
      references Product (ProductCode) on delete restrict on update restrict;

alter table POMain add constraint FK_P_V foreign key (VenderCode)
      references Vender (VenderCode) on delete restrict on update restrict;

alter table POMain add constraint FK_P_S foreign key (Account)
      references ScmUser (Account) on delete restrict on update restrict;

alter table Product add constraint FK_P_C foreign key (CategoryID)
      references Category (CategoryID) on delete restrict on update restrict;

alter table SOItem add constraint FK_S_P foreign key (ProductCode)
      references Product (ProductCode) on delete restrict on update restrict;

alter table SOItem add constraint FK_S_S foreign key (SOID)
      references SOMain (SOID) on delete restrict on update restrict;

alter table SOMain add constraint FK_S_C foreign key (CustomerCode)
      references Customer (CustomerCode) on delete restrict on update restrict;

alter table SOMain add constraint FK_S_U foreign key (Account)
      references ScmUser (Account) on delete restrict on update restrict;

alter table StockRecord add constraint FK_O_P foreign key (ProductCode)
      references Product (ProductCode) on delete restrict on update restrict;

alter table UserModel add constraint FK_UM_U foreign key (Account)
      references ScmUser (Account) on delete restrict on update restrict;

alter table UserModel add constraint FK_UM_SM foreign key (ModelCode)
      references SystemModel (ModelCode) on delete restrict on update restrict;

