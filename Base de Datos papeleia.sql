
--Se crea la base de datos
create database Papeleria

--Se usa esa base de datos
use Papeleria

--Creando tabla articulos

create table Articulos
(
IdArticulo int primary key identity (1,1) not null, --Llave primaria, autoincrementable
NombreArticulo varchar(50) not null,
Existencia int
)
--Creando tabla proveedor
create table Proveedor
(
IdProveedor int primary key identity(1,1) not null, --llave primaria, autoincrementable
NombreProveedor varchar(50) not null,
IdArticulo int foreign key  references Articulos(IdArticulo) not null -- llave foranea, relacionada con articulos
)

--Creando tabla clientes
create table Clientes 
(
IdCliente int primary key identity (1,1) not null, -- llave primaria, autoIncrementable
NombreCliente varchar(50) not null,
Fecha date default getdate(), -- fecha por defecto
IdProveedor int foreign key references Proveedor(IdProveedor) not null, -- llave foranea relacionada con proveedor
IdArticulo int foreign key references Articulos(IdArticulo) not null -- llave foranea relacionada con articulos
)

--Creando procedimeinto almacenado  para insertar articulos

create proc SP_InsertarArticulo 
(
@NombreArticulo varchar(50),
@Existencia int
)
as 
begin 
Insert into Articulos (NombreArticulo, Existencia)
values(@NombreArticulo, @Existencia)
end 

--Creando procedimeinto almacenado  para insertar Proveedores
create proc SP_insertarProveedor
(
@NombreProveedor varchar(50),
@IdArticulo int
)
as
 
 begin
 insert into Proveedor(NombreProveedor, IdArticulo)
 values(@NombreProveedor, @IdArticulo)
 end

 --Creando procedimeinto almacenado  para insertar Clientes
 create proc SP_InsertarClientes
 (
 @NombreCliente varchar(50),
 @IdProveedor int,
 @IdArticulo int
 )
 as 
 begin
 insert into Clientes (NombreCliente, IdProveedor, IdArticulo)
 values (@NombreCliente, @IdProveedor, @IdArticulo)
 end

 --Insertanto 10 articulos diferentes con su existencia

 exec SP_InsertarArticulo 'Lapiz', 10
  exec SP_InsertarArticulo 'Cuaderno', 16
   exec SP_InsertarArticulo 'Borra', 11
    exec SP_InsertarArticulo 'Papel', 20
	 exec SP_InsertarArticulo 'Lapicero', 15
	  exec SP_InsertarArticulo 'Borrador', 10
	   exec SP_InsertarArticulo 'Cartulina', 30
	    exec SP_InsertarArticulo 'Tempera', 10
		 exec SP_InsertarArticulo 'Saca punta', 50
		  exec SP_InsertarArticulo 'Grapadora', 10

 --Insertando 10 proveedores diferentes relacionados con el  Id de articulo

 exec SP_insertarProveedor 'Corripio',1
  exec SP_insertarProveedor 'Papeleria LN',2
   exec SP_insertarProveedor 'Prodimpa',3
    exec SP_insertarProveedor 'CCC',4
	 exec SP_insertarProveedor 'Papeleria 3',5
	  exec SP_insertarProveedor 'Intec',6
	   exec SP_insertarProveedor 'Jumbo',7
	    exec SP_insertarProveedor 'la Sirena',8
		 exec SP_insertarProveedor 'Bravo',9
		  exec SP_insertarProveedor 'Unapec',10

 --Insertando 10 Clientes diferentes relacionados con el Id de articulo y su proveedor

 exec SP_InsertarClientes 'Juan Mendez',1,2
  exec SP_InsertarClientes 'Pedro Martinez',2,3
   exec SP_InsertarClientes 'Papeleria LN',3,4
    exec SP_InsertarClientes 'Jonatan Francisco',5,5
	 exec SP_InsertarClientes 'Junior Hernandez',6,2
	  exec SP_InsertarClientes 'Mercadona',8,7
	   exec SP_InsertarClientes 'Papeleria Arroyo Hondo',9,10
	    exec SP_InsertarClientes 'La mejor',10,1
		 exec SP_InsertarClientes 'Papeleria MYS',5,9
		  exec SP_InsertarClientes 'Surtidora LM',7,9

--Haciendo una consulta para ver los clientes y su Id, sus articulos, su proveedor, su existencia y su fecha de creacion.

Select c.IdCliente, c.NombreCliente, a.NombreArticulo,  a.Existencia,p.NombreProveedor, c.Fecha from Clientes c

inner join Proveedor p -- usadno un join para unir la  tabla cliente con proveedor
on
c.IdProveedor = p.IdProveedor 

inner join Articulos a -- usando join para unir las tablas anteriores con la de articulos
on
c.IdArticulo = a.IdArticulo
-- El resultado mostrara cada cliente con su Id, articulo, proveedor, existencia y fecha
