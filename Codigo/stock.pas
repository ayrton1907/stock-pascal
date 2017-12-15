program stock;
uses UProductos,UAbm,crt;
var
  sPrincipal:boolean;
  lista: TLProducto;
  opcion:char;


//imprime menu principal.
procedure impMenuPrincipal();
begin
  ClrScr;
  writeln('-----MENU PRINCIPAL-----');
	Writeln('Seleccione una opción:');
  writeln('1)ABM y listado');
  writeln('2)Consultas');
  writeln('3)Salir y guardar');
  Write('Opcion: ');
end;


//Esta funcion  se encarga de guardar en el archivo, y luiego salir del programa.
procedure salidaPrincipal();
begin
  sPrincipal:=true;
end;


begin
  iniLista(lista);
  sPrincipal:=false;
  //inicio del ciclo
  while  (not sPrincipal) do
  begin
    impMenuPrincipal();
    readln(opcion);
    ClrScr;
    //ingresa a una opcion valida del menu, si no no hace nada.
    case opcion of
      '1': menuAbm (lista);

      '3': salidaPrincipal();
    end;
  end;
end.
