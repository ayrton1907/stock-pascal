unit UConsultas;

interface
uses UProductos,crt;
var
  //varable para salir del menu consulta
  sConsultas:boolean;

//imprime el menu ABM
procedure impMenuConsultas();

//lista todo los productos en orden alfabetico
procedure listadoAlf(p,q:TLProducto);

//listado de productos con falta de stock
procedure reposicion(p,q:TLProducto);

//Listado con excedente de productos
procedure excedente(p,q:TLProducto);

//sale del menu consulta
procedure salirConsultas ();

//menu
procedure menuConsultas(p,q:TLProducto);



implementation

procedure impMenuConsultas();
begin
  ClrScr;
  writeln('---------MENU CONSULTAS---------');
	Writeln('Seleccione una opción:');
  writeln('1)Listado por orden alfabetico');
  writeln('2)Productos que requieren reposicion ');
  writeln('3)Los 5 produtcos con mayor excedentes');
  writeln('4)Volver al menu anterior');
  Write('Opcion: ');
end;


procedure listadoAlf(p,q:TLProducto);
var
  s,d:TLProducto;//lista s,d
  i,j,aux:TLProducto;//punteros auxiliares

begin
  if (not vacio(p,q)) then
  begin
    //copiar la lista PQ a SD
    iniLista(s,d);
    aux:=p^.next;
    while (aux^.next <> nil) do
    begin
      insertarFinal(d,aux^.info);
      aux := aux^.next;
    end;
    //Ordenas la lista SD
    i:=d^.back;
    while (i<>s^.next) do
    begin
      j:=s^.next;
      while (j<>i) do
      begin
        aux:=j^.next;
        if (UpCase(j^.info.nombre)>UpCase(aux^.info.nombre)) then
        begin
          intercambiar(j^.info,aux^.info);//intercabia dos elementos
        end;
        j:=j^.next;
      end;
      i:=i^.back;
    end;
    writeln('listado de productos ordenados alfabeticamente');
    mostrar(s,0); //mostrar la lista
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


//listara todo los elementos que necesiten stock
procedure reposicion(p,q:TLProducto);
var
  s,d:TLProducto;//lista s,d
  i,j,aux:TLProducto;//punteros auxiliares

begin
  if (not vacio(p,q)) then
  begin
    //copiar la lista PQ a SD
    iniLista(s,d);
    aux:=p^.next;
    while (aux^.next <> nil) do
    begin
      if (aux^.info.existencia) < (aux^.info.stockMinimo) then
      begin
        insertarFinal(d,aux^.info);
      end;
      aux := aux^.next;
    end;
    //Ordenas la lista SD
    i:=d^.back;
    while (i<>s^.next) do
    begin
      j:=s^.next;
      while (j<>i) do
      begin
        aux:=j^.next;
        if (j^.info.stockMinimo-j^.info.existencia) < (aux^.info.stockMinimo-aux^.info.existencia) then
        begin
          intercambiar(j^.info,aux^.info);//intercabia dos elementos
        end;
        j:=j^.next;
      end;
      i:=i^.back;
    end;
    writeln('listado de productos faltantes');
    mostrar(s,0); //mostrar la lista
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

procedure excedente(p,q:TLProducto);
var
  s,d:TLProducto;//lista s,d
  i,j,aux:TLProducto;//punteros auxiliares

begin
  if (not vacio(p,q)) then
  begin
    //copiar la lista PQ a SD
    iniLista(s,d);
    aux:=p^.next;
    while (aux^.next <> nil) do
    begin
      if (aux^.info.existencia) > (aux^.info.stockMinimo) then
      begin
        insertarFinal(d,aux^.info);
      end;
      aux := aux^.next;
    end;
    //Ordenas la lista SD
    i:=d^.back;
    while (i<>s^.next) do
    begin
      j:=s^.next;
      while (j<>i) do
      begin
        aux:=j^.next;
        if (-j^.info.stockMinimo + j^.info.existencia) < (-aux^.info.stockMinimo + aux^.info.existencia) then
        begin
          intercambiar(j^.info,aux^.info);//intercabia dos elementos
        end;
        j:=j^.next;
      end;
      i:=i^.back;
    end;
    writeln('listado de productos excedentes');
    mostrar(s,5); //mostrar la lista
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


procedure salirConsultas ();
begin
  //sale del menu Aconsultas
  sConsultas:=true;
end;


procedure menuConsultas(p,q:TLProducto);
var
opcion:char;
begin
  sConsultas:=false;
  //inicio del ciclo
  while  (not sConsultas) do
  begin
    impMenuConsultas();
    readln(opcion);
    ClrScr;
    //ingresa a una opcion valida del menu, si no no hace nada.
    case opcion of
      '1': listadoAlf (p,q);
      '2': reposicion(p,q);
      '3': excedente(p,q);
      '4': salirConsultas ();
    end;
  end;
end;


end.
