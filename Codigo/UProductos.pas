unit UProductos;

interface
//declaracion de tipo producto que cuenta con tres campo.
type
  TProducto = record
                nombre:string;//nombre del producto
                stockMinimo:integer;//cantiodad de stock minima que deberia existir
                existencia:integer;//cantidad de producto en existencia
              end;
  //tipo de archivo de productos.
  TAProducto= file of TProducto;
  // Tnodo para lista de productos, la misma sera  LSE y con ficticio
  TNProducto = record
                info:TPersona;
                next:^TNProducto;
              end;
  (*tipo lista es creado para pasar un puntero de TNodo como parametro ya
  que pascal no permite colocar eso como parametro*)
  TLProducto=^TNProducto;


// inicializa la lista y su ficticio.
procedure iniLista(var p:TLProducto);

// Debuelve verdadero si la lista esta vacia y falso si no.
function vacio(p:TLProducto):boolean;

//Inserta un nuevo producto al inicio de la lista.
procedure insertar( p:TLProducto; info:TProducto);

//verifica si existe el producto
function existeNombre(p:TLProducto;nombre:string):boolean;

//Elimina un elemento de la lista  segun su nombre
procedure eliminar(p:TLProducto;nombre:string);

// Edicion de un  elemento segun su nombre.
procedure modificar(p:TLProducto;info:TPersona);

(*mostrara un listado de todo los productos segun su orden de carga, esto teniendo en
cunta que se carga los elemento al principio de la lista*)
procedure mostrar(p:TLProducto);




implementation


procedure iniLista(var p:TLProducto);
begin
    new(p);
    p^.next:=nil;
end;
function vacio(p:TLProducto):boolean;
begin
  //si no tiene un elemento despues del ficticio la lista esta vacia
  if (p^.next=nil)then
    begin
        vacio:=true;
    end;
end;

procedure insertar( p:TLProducto; info:TProducto);
var
  aux,primero:TLProducto;
begin
  new(aux);//se crea un TNProducto para colocar un nuevo producto
  //se encadena el nodo con la lista
  primero:=p^.next;
	p^.next := aux;
  //se coloca la informacion
	aux^.next := primero;
	aux^.info := info;
end;


function existeNombre(p:TLProducto;nombre:string):boolean;
var
  aux:TLProducto;
begin
  aux:=p^.next;
	while (aux <> nil) and (p^.info.nombre <> nombre) do
	begin
   //Avanzar
		aux := aux^.next;
	end;
  if (p^.info.nombre=nombre) then
  begin
    //informa la existencia o no del nombre
    existeNombre:=true;
  end;
end;

procedure eliminar(p:TLProducto;nombre:string);
begin
   ant:= p;
   aux:=ant^.next;
   sig := aux^.next;
   while (aux <> nil) and (p^.info.nombre=nombre) do
   begin
     //Avanzar
     ant:= ant^.next;
     aux:=ant^.next;
     sig := aux^.next;
   end;
   if (p^.info.nombre=nombre) then
   begin
     //elimina el elemento de la lista, y la encadena
     dispose(aux);
     ant^.next := sig;
   end;
 end;


procedure modificar(p:TLProducto;info:TPersona);
var
  aux:TLProducto;
begin
  aux:=p^.next;
	while (aux <> nil) and (p^.info.nombre <> nombre) do
	begin
    //Avanzar
		aux := aux^.next;
	end;
  if (p^.info.nombre=nombre) then
  begin
    //modifica los datos del producto
    aux^.info:=info;
  end;
end;


procedure mostrar(p:TLProducto);
var
  aux:TLProducto;
begin
  aux:=p^.next;
	while (aux <> nil) do
	begin
    writeln('•Nombre: ',aux^.info.nombre);
    writeln('•stock minimo: ',aux^.info.stockMinimo);
    writeln('•stock existente: 'aux^.info.existencia);
    writeln('--------------------------------------');
    aux := aux^.next; //Avanzar
	end;
end;


end.
