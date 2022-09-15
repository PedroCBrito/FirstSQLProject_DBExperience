-- criacao do banco de dados para o cenario de E-commerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table client(
	idClient int auto_increment primary key,
    Fname varchar(15),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Adress varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table client auto_increment =1;
desc client;


-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(15),
    category enum('Eletronico', 'Acessorio', 'Vestuario', 'Livro'),
    avaliation float default 0
);

alter table product auto_increment =1;

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
    orderStatus enum('Cancelado', 'Em andamento', 'A caminho', 'Finalizado') default 'Em andamento',
    orderDescription varchar(250),
    sendValue float default 0,
    payment enum('Boleto', 'Deposito', 'Cartoes', 'PIX'),
    constraint fk_orders_client foreign key (idOrderClient) references client(idClient)
);
alter table orders auto_increment =1;

-- criar tabela cartoes
create table creditcards(
	idCard int auto_increment primary key,
	idCardClient int,
    idCardOrder int,
    datevalid date not null,
    numbercard varchar(15) not null,
    constraint fk_card_client foreign key (idCardClient) references client(idClient),
    constraint fk_card_order foreign key (idCardOrder) references orders(idOrder)
);
alter table creditcards auto_increment =1;


-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
    quantity int default 0
);

alter table productStorage auto_increment =1;


-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
	socialName varchar(250) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment =1;


-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
	socialName varchar(250) not null,
    CNPJ char(15),
    CPF char(9),
    location varchar(250),
    contact char(11) not null,
    constraint unique_CNPJ_supplier unique (CNPJ),
    constraint unique_CPF_supplier unique (CPF)
);
alter table seller auto_increment =1;
alter table seller add CNPJ char(15);

-- criar tabela produto por vendedor
create table productSeller(
	idPSeller int,
	idProduct int,
	prodQuantity int default 1,
    primary key(idPSeller,idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);



-- criar tabela produto por pedido
create table productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
    poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key(idPOproduct,idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);


-- criar tabela estoque do produto
create table storageLocation(
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
    primary key(idLproduct,idLstorage),
    constraint fk_storage_location_seller foreign key (idLProduct) references product (idProduct),
    constraint fk_storage_location_product foreign key (idLstorage) references productStorage(idProdStorage)
);


-- Adcionando CNPJ e verificaca se eh PJ na tabela cliente
alter table client add column CNPJ varchar(15);
alter table client add constraint unique_CNPJ_supplier unique (CNPJ);
alter table client add column PJ boolean default 0;
desc client;

-- criar tabela produto para pedido e vendedor
create table productSupplier(
	idPsSupplier int,
	idPsProduct int,
	quantity int not null,
    primary key(idPsSupplier,idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

-- vendo constraints em db ecommerce
use information_schema;
show tables;
desc table_constraints;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

-- criando tabela entrega
create table delivery(
	idDelivery int auto_increment primary key,
	Status ENUM('Separando', 'A caminho', 'Entregue'),
    codetracking char(15),
    idOrderDelivery int,
    constraint unique_codetracking unique (codetracking),
	constraint fk_delivery_order foreign key (idOrderDelivery) references orders(idOrder)
);