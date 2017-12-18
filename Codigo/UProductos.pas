unit UProductos;

interface
uses crt;
//declaracion de tipo producto que cuenta con tres campo.
type
  TProducto = record
                nombre:string;//nombre del producto
                stockMinimo:integer;//cantiodad de stock minima que deberia existir
                existencia:integer;//cantidad de producto en existencia
              end;
  //tipo de archivo de productos.
  TAProducto= file of TProducto;
  // Tnodo para lista de productos, la misma sera  LDE y con ficticio
  TNProducto = record
                info:TProducto;
                next,back:^TNProducto;
              end;
  (*tipo lista es creado para pasar un puntero de TNodo como parametro ya
  que pascal no permite colocar eso como parametro*)
  TLProducto=^TNProducto;

//Si existe el archivo lo carga en la lista
procedure cargarArch (var arch:TAProducto;q:TLProducto);

//guarda la lista en el archivo, si no existe lo crea
procedure guardarArch (var arch:TAProducto;p:TLProducto);

// inicializa la lista y su ficticio.
procedure iniLista (var p,q:TLProducto);

// Debuelve verdadero si la lista esta vacia y falso si no.
function vacio (p,q:TLProducto):boolean;

//Inserta un nuevo producto al inicio de la lista.
procedure insertar (var p:TLProducto; info:TProducto);

//Inserta un nuevo producto al final de la lista.
procedure insertarFinal (var q:TLProducto; info:TProducto);

//verifica si existe el producto
function existeNombre (p:TLProducto;nombre:string):boolean;

//Elimina un elemento de la lista  segun su nombre
procedure eliminar (p:TLProducto;nombre:string);

// Edicion de un  elemento segun su nombre.
procedure modificar(p:TLProducto;info:TProducto);

(*mostrara un listado de todo los productos segun su orden de carga, esto teniendo en
cunta que se carga los elemento al principio de la lista*)
procedure mostrar(p:TLProducto;max:integer);

//accion para intercambiar Productos
procedure intercambiar(var p1,p2:TProducto);


implementation

procedure cargarArch (var arch:TAProducto;q:TLProducto);
var
  prod:TProducto;
begin
  {$I-}
  reset(arch);
  {$I+}
  if (IOResult = 0) then
  begin
    while not(EOF(arch)) do
    begin
      read(arch,prod);
      insertarFinal(q,prod);
    end;
    close(arch);
  end;
end;


//guarda la lista en el archivo productos.dat
procedure guardarArch (var arch:TAProducto;p:TLProducto);
var
  aux:TLProducto;
begin
  rewrite(arch);
  aux:=p^.next;
	while (aux^.next <> nil) do
	begin
    write(arch,aux^.info);
    aux := aux^.next; //Avanzar
	end;
end;


//inicia la lista
procedure iniLista(var p,q:TLProducto);
begin
    new(p);
    new(q);
    p^.back:=nil;
    p^.next:=q;
    q^.back:=p;
    q^.next:=nil;

end;
function vacio(p,q:TLProducto):boolean;
begin
  //si no tiene un elemento despues del ficticio la lista esta vacia
  if (p^.next=q)then
  begin
      vacio:=true;
  end
  else
  begin
    vacio:=false;
  end;
end;


procedure insertar( var p:TLProducto; info:TProducto);
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


procedure insertarFinal( var q:TLProducto; info:TProducto);
var
  aux,ultimo:TLProducto;
begin
  new(aux);//se crea un TNProducto para colocar un nuevo producto
  //se encadena el nodo con la lista
  ultimo:=q^.back;
	q^.back := aux;
	aux^.back := ultimo;
  aux^.next:=q;
  ultimo^.next:=aux;
    //se coloca la informacion al final
	aux^.info := info;
end;



function existeNombre( p:TLProducto;nombre:string):boolean;
var
  aux:TLProducto;
begin

  aux:=p^.next;
	while (aux^.next <> nil) and (aux^.info.nombre <> nombre) do
	begin
   //Avanzar
		aux := aux^.next;
	end;
  if (aux^.next <> nil) then
  begin
    //informa la existencia o no del nombre
    existeNombre:=true;
  end
  else
  begin
    existeNombre:=false;
  end;
end;


procedure eliminar(p:TLProducto;nombre:string);
var
  ant,aux,sig:TLProducto;
begin
   ant:= p;
   aux:=ant^.next;
   sig := aux^.next;
   while (aux^.next <> nil) and (aux^.info.nombre <> nombre) do
   begin
     //Avanzar
     ant:= ant^.next;
     aux:=ant^.next;
     sig := aux^.next;
   end;
   if (aux^.next <> nil) then
   begin
     //elimina el elemento de la lista, y la encadena
     dispose(aux);
     ant^.next := sig;
   end;
 end;


procedure modificar(p:TLProducto;info:TProducto);
var
  aux:TLProducto;
begin
  aux:=p^.next;
	while (aux^.next <> nil) and (aux^.info.nombre <> info.nombre) do
	begin
    //Avanzar
		aux := aux^.next;
	end;
  if (aux^.next <> nil) then
  begin
    //modifica los datos del producto
    aux^.info:=info;
  end;
end;


procedure mostrar(p:TLProducto;max:integer);
var
  aux:TLProducto;
  contador:integer;
begin
  aux:=p^.next;
  contador:=1;
  //si el valor ingresado no es cero se aumenta el valor de max en 1
  //para que al recorrer el ciclo muestre hasta el elemento numero max.
  if (max <> 0) then
  begin
    max:=max+1;
  end;
  //en cambio,si max es cero, ignora la condicion "(contador <> max)" y muestra toda la lista.
	while (aux^.next <> nil) and (contador <> max) do
	begin
    writeln('•Nombre: ',aux^.info.nombre);
    writeln('•stock minimo: ',aux^.info.stockMinimo);
    writeln('•stock existente: ',aux^.info.existencia);
    if (aux^.info.stockMinimo-aux^.info.existencia) > 0 then
    begin
      TextColor(Red);
      writeln('•stock faltante: ',(aux^.info.stockMinimo-aux^.info.existencia));
      TextColor(white);
    end
    else if (-aux^.info.stockMinimo+aux^.info.existencia) > 0 then
    begin
      TextColor(green);
      writeln('•stock excedentes: ',(-aux^.info.stockMinimo+aux^.info.existencia));
      TextColor(white);
    end;
    writeln('--------------------------------------');
    aux := aux^.next; //Avanzar
    contador+=1;
	end;
end;


//accion para intercambiar Productos
procedure intercambiar(var p1,p2:TProducto);
var
  aux:TProducto;
begin
  aux:=p1;
  p1:=p2;
  p2:=aux;
end;


end.
