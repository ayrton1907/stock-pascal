unit UAbm;

interface
uses UProductos,crt;
var
  //varable para salir del menu abm
  sAbm:boolean;

//imprime el menu ABM
procedure impMenuAbm ();

//Agrega un producto
procedure alta (p:TLProducto);

//modifica un producto
procedure baja (p,q:TLProducto);

//modifica un producto
procedure modificacion (p,q:TLProducto);

//liosta todo los productos
procedure listado (p,q:TLProducto);

//sale del menu ABM
procedure salirAbm (var arch:TAProducto;p:TLProducto);

//menu
procedure menuAbm(var arch:TAProducto;p,q:TLProducto);


implementation


procedure impMenuAbm();
begin
  ClrScr;
  writeln('---------MENU ABM---------');
	Writeln('Seleccione una opción:');
  writeln('1)Alta de producto');
  writeln('2)Baja de producto');
  writeln('3)Modificar producto');
  writeln('4)Listado de producto');
  writeln('5)Volver al menu anterior');
  Write('Opcion: ');
end;


procedure alta ( p:TLProducto);
var
  info:TProducto;
begin
  write('Ingrese el nombre del producto: ');
  readln(info.nombre);
  if (existeNombre(p,info.nombre)) then
  begin
    writeln('El producto ya existe, intente nuevamente.');
    writeln('Presione una tecla para continuar');
    readkey;
    //vuelve al menu principal, sin crear ningun producto
  end
  else
  begin
    //si no, carga los datos faltantes, y vuelve al menu principal
    write('Ingrese el stock minimo: ');
    readln(info.stockMinimo);
    write('Ingrese la cantidad de productos que existen en stock: ');
    readln(info.existencia);
    //se inserto el producto en la lista
    insertar( p,info);
    writeln('El producto se inserto.');
    writeln('Presione una tecla para continuar');
    readkey;
  end;
end;


procedure baja (p,q:TLProducto);
var
  nombre:string;
begin
  write('Ingrese el nombre del producto: ');
  readln(nombre);
  if (not vacio(p,q)) and (existeNombre(p,nombre)) then
  begin
    eliminar(p,nombre);
    writeln('El producto se elimino.');
    writeln('Presione una tecla para continuar');
    readkey;
    //elimina el producto y vuelve al menu principal.
  end
  else
  begin
    writeln('El producto no existe, intente nuevamente.');
    writeln('Presione una tecla para continuar');
    readkey;
  end;
end;


procedure modificacion (p,q:TLProducto);
var
  info:TProducto;
begin
  write('Ingrese el nombre del producto: ');
  readln(info.nombre);
  if (not vacio(p,q)) and (existeNombre(p,info.nombre)) then
  begin
    //carga los datos
    write('Ingrese la nueva cantidad del stock minimo: ');
    readln(info.stockMinimo);
    write('Ingrese la nueva cantidad de productos que existen en stock: ');
    readln(info.existencia);
    //se guardan las modificaciones
    modificar(p,info);
    writeln('El producto se modifico.');
    writeln('Presione una tecla para continuar');
    readkey;
    //vuelve al menu principal
  end
  else
  begin
    //vuelve al menu principal, sin modificar ningun producto
    writeln('El producto no existe, intente nuevamente.');
    writeln('Presione una tecla para continuar');
    readkey;
  end;
end;


procedure listado (p,q:TLProducto);
begin
  if (not vacio(p,q)) then
  begin
    writeln('listado de productos');
    mostrar(p,0);
    writeln('Presione una tecla para continuar');
    readkey;
    //vuelve al menu principal
  end
  else
  begin
    writeln('listado de productos vacia');
    writeln('Presione una tecla para continuar');
    readkey;
    //vuelve al menu principal
  end;
end;



procedure salirAbm (var arch:TAProducto;p:TLProducto);
begin
  //sale del menu ABM
  sAbm:=true;
  guardarArch(arch,p);
end;


procedure menuAbm(var arch:TAProducto;p,q:TLProducto);
var
opcion:char;
begin
  sAbm:=false;
  //inicio del ciclo
  while  (not sAbm) do
  begin
    impMenuAbm();
    readln(opcion);
    ClrScr;
    //ingresa a una opcion valida del menu, si no no hace nada.
    case opcion of
      '1': alta (p);
      '2': baja (p,q);
      '3': modificacion (p,q);
      '4': listado (p,q);
      '5': salirAbm (arch,p);
    end;
  end;
end;


end.
