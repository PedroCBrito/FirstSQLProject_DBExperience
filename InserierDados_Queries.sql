-- insercao de dados
use ecommerce;

-- inserindo dados riados no mockaroo na tabela client
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Dolf', 'N', 'Niles', '17-890-6739', '265 Maple Pass', 0, NULL);
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Yoko', 'C', 'Cory', '20-193-8125', '499 Kingsford Parkway', 0, NULL);
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Paige', 'H', 'Hedgeley', NULL, '1 Gulseth Drive', 1, '92-176-5177');
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Jordanna', 'V', 'Victory', NULL, '79959 Weeping Birch Crossing', 1, '86-800-5846');
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Evangelina', 'D', 'Dyott', NULL, '29637 Service Crossing', 1, '05-027-8625');
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Clara', 'D', 'Dorgan', '57-110-3974', '0832 Crescent Oaks Point', 0, NULL);
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Jillana', 'H', 'Hablet', '17-277-3630', '65 Florence Street', 0, NULL);
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Marge', 'J', 'Jann', '06-824-8917', '70 Ruskin Alley', 0, NULL);
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Ruthanne', 'V', 'Vyvyan', '52-768-2991', '41744 Moose Way', 0, NULL);
insert into client (Fname, Minit, Lname, CPF, Adress, PJ, CNPJ) values ('Salaidh', 'J', 'Janouch', '56-163-4728', '3033 Nancy Street', 0, null);

select * from client;

-- inserindo produtos
insert into product (Pname, category, avaliation) values
				('Fone', 'Eletronico','4'),
				('Camisa', 'Vestuario','5'),
                ('Microfone', 'Eletronico','4'),
                ('Bone', 'Acessorio','3');
                
select * from product;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, payment) values
				(12,default,'compra via aplicativo',default,'PIX'),
				(13,default,'compra via aplicativo',50,'Boleto'),
                (15,'A caminho',null,null,'Boleto'),
                (21,'Finalizado','compra via web site',150,'Deposito');
                
select * from orders;

-- inserindo dados em productOrders
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						(1,17,2,'Disponivel'),
						(2,18,1,'Disponivel'),
						(3,19,6,'Disponivel'),
						(4,19,2,'Disponivel');
                                            
                                                
                                                
-- inserindo dados em productStorage
insert into productStorage (storageLocation, quantity) values
							('Rio de Janeiro', 1000),
 							('Brasilia', 60),                           
  							('Sao Paulo', 300),                          
  							('Rio de Janeiro', 500),                          
  							('Sao Paulo', 10);      
                            
select * from productStorage;



-- inserindo dados em storageLocation
insert into storageLocation(idLproduct, idLstorage, location) values
							(1,1,'RJ'),
							(2,2,'GO'),
							(3,5,'SP');
                            
                            
                            
-- inserindo dados em supplier
insert into supplier (SocialName, CNPJ, contact) values
					 ('Almeida e filhos',123456789, '1252154'),
 					 ('Eletronicos Silva',6455312964, '612434'),                           
 					 ('Microlight',87676586, '4975473'),        
					 ('Lojinha boa',64597878, '172134');       
select * from supplier;

-- inserindo dados em productSupplier
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
							(5,1,520),
 							(6,2,400),
 							(7,4,5),                           
							(8,2,10);
 		
 select * from productSupplier;       
        
  -- inserindo dados em seller      
insert into seller(socialName,CNPJ,CPF,location,contact) values
					('Tech eletronics',123456789978, null,'Rio de Janeiro', 211245215),
					('Mercado legal',null, 51513535,'Rio de Janeiro', 21986593511),                    
					('kids doidas',25151322351, null,'Sao Paulo', 1165464549),
                    ('Microlight',87676586,null,'Itu', 1140224265); 
         select * from seller;          
                 
                
  -- inserindo dados em productSeller      
insert into productSeller(idPSeller,idProduct,prodQuantity) values 
						(1,2,80),
  						(2,1,10);                  
select * from productSeller;        

insert into creditcards (idCardClient, idCardOrder, datevalid, numbercard) values 
							(15, 17, '2022-3-2', '36312429767277'),
							(15, 20, '2022-5-9', '36388184954847'),
							(19, 20, '2022-8-24', '35690725336'),
							(17, 20, '2022-3-5', '3580134625601'),
							(21, 18, '2021-11-30', '201729570075'),
							(16, 20, '2021-10-31', '5371429729237'),
							(14, 19, '2022-1-23', '30315330788650'),
							(15, 17, '2022-4-27', '5602227754801');
             
             
  insert into delivery ( Status, codetracking, idOrderDelivery) values   
						('Separando', null, 17 ),
						('Separando', null, 18 ),                       
 						('A caminho', '15425452', 19 ),   
                        ('Entregue', '542152452', 20);
                        
                        
                        
-- Recuperar quantos pedidos foram feitos pelos clientes?
select c.idClient, Fname, count(*)as Number_of_orders from client as c
						inner join orders as o ON c.idClient = o.idOrderClient
						group by idClient;
                    
 -- Recuperacao de pedido com produto associado
 select c.idClient, c.Fname as Cliente ,o.idOrder as Pedido, o.orderStatus as Condicao from client as c
					inner join orders as o ON c.idClient = o.idOrderClient
                    inner join productOrder as p ON p.idPOorder = o.idOrder
			group by idClient;
                    
                    
 -- Recuperando cartoes por usuario
select c.Fname, cred.numbercard as Number_Card, cred.datevalid as DateValid from client as c
		inner join creditcards as cred ON c.idClient = cred.idCardClient
	group by c.idClient;
    
-- Recuperando onde os pedidos ja foram finalizados
select * from orders as o
	where o.orderStatus = 'Finalizado';
                         
 -- Algum vendedor também é fornecedor? 
 select s.idSeller, s.socialName as Name, s.CNPJ from seller as s
		inner join supplier as sup ON s.CNPJ = sup.CNPJ;
	
    
-- Relação de produtos fornecedores e estoques / Relação de nomes dos fornecedores e nomes dos produtos;	
select s.idSupplier, s.socialName, s.CNPJ, p.Pname as Name_Product, ps.quantity, p.category  from supplier as s
		inner join productSupplier as ps ON  s.idSupplier = ps.idPsSupplier
        	inner join product as p ON  ps.idPsProduct = p.idProduct;
            
            
-- O que os vendedores oferecem?
select s.idSeller, s.socialName as Name, p.Pname as Product_Name, ps.prodQuantity as Quantity from seller as s
	inner join productSeller as ps ON s.idSeller = ps.idPSeller
		inner join product as p ON ps.idProduct = p.idProduct;

	
