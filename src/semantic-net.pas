{
  Nome: Arthur Alexsander Martins Teodoro   Matrícula: 0022427;
	Nome: Saulo Ricardo Dias Fernandes        Matrícula: 0021581;
  Nome: Wesley Henrique Batista Nunes       Matrícula: 0021622;
}
program semanticnet;

  uses CRT, SysUtils;

  var
    caminho_entrada, caminho_saida : string;
    ArqEnt, ArqSai : TextFile;
    matriz : array of array of integer;
    lookup_nos, lookup_relacionamentos : array of string;
    quant_nos, quant_arcos : integer;
 
procedure LookupTableNos(linha:string);
begin
  //aumenta um no tamanho do lookup table para nos
  SetLength(lookup_nos,length(lookup_nos)+1);
  //deleta duas vezes até sobrar a descricao
  delete(linha,1,pos(' ',linha));
  delete(linha,1,pos(' ',linha));
  //passa a descricao para a lookup table
  lookup_nos[length(lookup_nos)-1] := linha;  
end;

procedure LookupTableRelacionamentos(linha:string);
var
  index : integer;
begin
  //deleta o caracter de controle
  delete(linha,1,pos(' ',linha));
  //pega o ID do relacionamento
  index := StrToInt(copy(linha,1,pos(' ',linha)-1));
  //decrementa um do ID do relacionamento, o que corresponde a uma posiçao da lookup table
  dec(index);
  //deleta o ID do relacionamento
  delete(linha,1,pos(' ',linha));
  //passa a descrição do relacionamento para o lookup table
  lookup_relacionamentos[index] := linha;  
end;

procedure FazRelacionamentos(linha :string);
var colunaMatriz, linhaMatriz, tipo: integer;
begin
//deleta o caractere de controle
delete(linha,1,2);
//pega a ligação de origem do relacionamento
LinhaMatriz := StrToInt(Copy(linha,1,pos(' ',linha)-1)) -1;
//deleta a ligação de origem do relacionamento
delete(linha,1,pos(' ',linha));
//pega a ligação de destino do relacionamento
colunaMatriz := StrToInt(Copy(linha,1,pos(' ',linha)-1)) -1;
//deleta a ligação de destino do relacionamento
delete(linha,1,pos(' ',linha));
//pega o tipo de relacionamento
tipo := StrToInt(Copy(linha,1,Length(linha)));
//delete(linha,1,pos(' ',linha));
Matriz[LinhaMatriz,ColunaMatriz] := tipo;
//soma um à quantidade de arcos
inc(quant_arcos);    
end;
  
//procedimento de leitura do arquivos
procedure EntradaArquivo(entrada:string);	
var
  linha : string;
  fchar : string;
  i : integer;	
begin
  //Vincula o arquivo de entrada à variável entrada
  Assign(ArqEnt,entrada);
  //Abre o arquivo de entrada
  Reset(ArqEnt);
  while not(EOF(ArqEnt)) do
    begin
      //le cada linha do arquivo e pega o caractere de cada linha
    	readln(ArqEnt,linha);
    	fchar := copy(linha,1,1);
    	case fchar of
    	  'N' : begin
    	          //le a qauntidade de nos que existe na matriz
    	          quant_nos := StrToInt(copy(linha,pos(' ',linha),length(linha)));
    	          //seta o tamanho da matriz com a quantidade de nos
    	          SetLength(matriz,quant_nos);
    	          for i := 0 to length(matriz)-1 do
    	            begin
										SetLength(matriz[i],quant_nos);
    	            end;   
    	        end;
    	  'n' : begin
							  LookupTableNos(linha);	
    	        end;
    	  'K' : begin
    	          //Seta o tamanho da lookup table de relacionamentos
							  SetLength(lookup_relacionamentos,StrToInt(copy(linha,pos(' ',linha),length(linha))));
    	        end;
    	  'k' : begin
							  LookupTableRelacionamentos(linha);	
    	        end; 
    	  'r' : begin
    	          FazRelacionamentos(linha);  
    	        end;                
    	end;
    end;
  Close(ArqEnt);  
end;

function mapeamento_no(no:integer):string;
begin
  //vai na posicao da lookup onde está o nó buscado
  dec(no);
  mapeamento_no := lookup_nos[no];    
end;

function mapeamento_relacionamento(relacao:integer):string;
begin
  //vai na posicao da lookup onde está o relacionamentos buscado
  dec(relacao);
  mapeamento_relacionamento := lookup_relacionamentos[relacao];
end;

procedure BuscaRelacionamentos;
var
  quant_relacionamentos : array of integer;
  i,j, posicao : integer;
begin
  //seta o tamanho do vetor para o tamanho da lookup de relacionamentos
  SetLength(quant_relacionamentos,length(lookup_relacionamentos));
  //percorre toda a matriz em busca de relacionamentos
  for i	:= 0 to length(matriz)-1 do
    begin
			for j := 0 to length(matriz)-1 do
			  begin
			    //se for diferente de 0 quer dizer que existe um relacionamento
			    if matriz[i,j] <> 0
			      then begin
									 //pega o tipo de relacionamento da matriz	
			             posicao := matriz[i,j];
			             dec(posicao);
			             //adiciona mais um no vetor 
								   quant_relacionamentos[posicao] := quant_relacionamentos[posicao] + 1;	 
			           end;
			  end;
    end;
  //escreve o vetor   
  for i := 0 to length(quant_relacionamentos)-1 do
    begin   
      writeln('- ',mapeamento_relacionamento(i+1),': ',quant_relacionamentos[i],'/',quant_arcos);
    end;  
end;

function BuscaNos(no:integer):string;
var
  i, quant : integer;
begin
  //primeiro pega o nome do arco
  BuscaNos := '- '+mapeamento_no(no+1);
  //verifica quantos arcos entram
  quant := 0;
  for i	:= 0 to length(matriz)-1 do
    begin
      //vai na matri buscando os nos
		  if matriz[i,no] <> 0
		    then begin
							 inc(quant);
		         end;       		
    end;
  //se a quantidade nao existir é porque é source  
  if quant = 0
    then begin
					 BuscaNos := BuscaNos + ': In '+IntToStr(quant)+' (it'+chr(39)+'s a source), ';
         end
  //se existir nos de entrada       
    else begin
					 BuscaNos := BuscaNos + ': In '+IntToStr(quant)+', ';
         end;
  quant := 0;
  for i := 0 to length(matriz)-1 do
    begin
      //faz a busca na linha correspondente da matriz 
			if matriz[no,i] <> 0
			  then begin
						   inc(quant);
			       end;
    end;
  //se a quantidade nao existir é porque é sink  
  if quant = 0
    then begin
           BuscaNos := BuscaNos + 'Out '+IntToStr(quant)+' (it'+chr(39)+'s a sink)';
         end
  //Se existir no de saida       
    else begin
           BuscaNos := BuscaNos + 'Out '+IntToStr(quant);
         end;                      
end;

procedure Estatisticas;
var
  density : real;
  i : integer;
begin
  writeln('');
  writeln('Statistics:');
  writeln('===========');
  writeln('');
  writeln('1. General');
  writeln('');
  writeln('- Number of Nodes: ',quant_nos);
  writeln('- Number of Edges: ',quant_arcos);
  //faz o calculo da densidade que é arcos/nos²
  density := (quant_arcos/(quant_nos*quant_nos))*100;
  writeln('- Density:         ',density:0:2,'%');
  writeln('');
  writeln('2. By Types of Relationship');
  writeln('');
  //faz a busca de quantas vezes os arcos apareceram
  BuscaRelacionamentos;
  writeln('');
  writeln('3. By Nodes');
  writeln('');
  //roda a busca de nos
  for i := 0 to length(matriz)-1 do
    begin
			writeln(BuscaNos(i));
    end;
  writeln('');
  writeln('End of processing.');
  writeln('');  
end;

procedure GeraSaida(caminho:string);
var
  k,l,tipo,i,j : integer;
begin
  //atribui o arquivo de saida à variável
  Assign(ArqSai,caminho);
  //apaga todo o arquivo e coloca a posicao do ponteiro no primeiro
  Rewrite(ArqSai);
  writeln(ArqSai,'digraph Rede {');
  for i := 0 to length(lookup_nos)-1 do
    begin
      //grava a lookup no arquivo de saida
      k := i;
      inc(k);
			writeln(ArqSai,#9#9+IntToStr(k)+' [label="'+mapeamento_no(i+1)+'"];');
    end;
  for i := 0 to length(matriz)-1 do
    begin
      for j := 0 to length(matriz)-1 do
        begin
          if matriz[i,j] <> 0
            then begin
                   k := i;
                   l := j;
                   inc(k);
                   inc(l);
                   tipo := matriz[i,j];
                   //grava os relacionamentos no arquivo de saida
                   writeln(ArqSai,#9#9+IntToStr(k)+' -> '+IntToStr(l)+' [label="'+mapeamento_relacionamento(tipo)+'"];');
                 end;
        end; 
    end;  
  writeln(ArqSai,'}');
  //fecha o arquivo
  Close(ArqSai);
end;	

begin
  SetLength(lookup_nos,0);
  if(ParamCount < 2)
  then begin
         writeln('Digite o nome dos arquivos de entrada e saída');
         exit;
       end
  else begin
         caminho_entrada := ParamStr(1);
         caminho_saida := ParamStr(2);
         EntradaArquivo(caminho_entrada);
         Estatisticas;
         GeraSaida(caminho_saida); 
       end;         
end. 
