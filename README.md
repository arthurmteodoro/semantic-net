# semantic-net

## Objetivo
Este projeto tem a finalidade de implementar um software capaz de representar uma rede semântica usando a linguagem pascal, o compilador FPC, como Trabalho Prático da disciplina Matemática Discreta, do curso de Ciência da Computação no Instituto Federal de Minas Gerais(IFMG) - Campus Formiga.

## Redes Semânticas
Uma rede semântica é um grafo que comtêm nós e arcos direcionados. Os nós de uma rede semântica são usadas para modelar objetos, situações e conceitos; já os arcos da rede modelam relacionamentos binários entre eles. Tanto os nós da rede quanto os arcos da rede são rotulados para identificar os objetos e relacionamentos que representam. Em geral, redes semânticas fornecem um modo intuitivo de representar conhecimento sobre objetos e relacionamentos entre elas. O sentido do arco indica quem se relaciona com quem.

## Instalação

Para fazer o uso do semantic-net deve-se usar basicamente dois aplicativos:
  GraphViz;
  Free Pascal Compiler;
### Instalaçao GraphViz:
Para ser feita a instalação do pacote GraphViz, no Windows, faça o download da ultima versão do [GraphViz](http://www.graphviz.org/Download.php).

Já em distribuições baseados em Debian(Ubuntu), use o comando `sudo apt-get install graphviz`

### Instalação do FPC(Free Pascal Compiler)

Faça o download da última versão do [FPC](http://www.freepascal.org/download.var)

## Uso do software

No uso do software, a entrada de dados será feita mediante arquivo ASCII cujo formato será conhecido a priori.
A inicialização do aplicativo, na plataforma Linux, será executados desta forma:
`user@machine$ ./semantic-net <arquivo-entrada> <arquivo-saida>`
onde <arquivo-entrada> corresponde ao nome de um arquivo de entrada no formato ASCII informado pelo
usuário no terminal que conterá os objetos, conceitos e ideias da rede semântica com seus tipos de relacionamento, no seguinte formato, sendo cada linha iniciada por um caractere de controle:

|---------------------------------------------------------------|

|# <string: linha de comentario, ignorada até o CR>             |

|N <inteiro: número de objetos, conceitos ou idéias>            |

|n <natural: id> <string: nome do objeto, conceito ou idéia>    |

|n <natural: id> <string: nome do objeto, conceito ou idéia>    |

|n <natural: id> <string: nome do objeto, conceito ou idéia>    |

|...                                                            |

|K <inteiro: número de tipos de relacionamento>                 |

|k <inteiro: id> <string: nome do relacionamento>               |

|k <inteiro: id> <string: nome do relacionamento>               |

|k <inteiro: id> <string: nome do relacionamento>               |  

|...                                                            |

|r <inteiro: inicial> <inteiro: final> <inteiro: tipo>          |

|...                                                            |        

|f                                                              |

|---------------------------------------------------------------|

onde:

• N: indica o número total de nós da rede semântica

• n: identifica unicamente cada nó da rede, com ID e descrição

• K: indica o número total de tipos de relacionamento da rede

• k: identifica unicamente cada tipo de relacionamento (arco) por meio de ID e descrição

• r: cria um relacionamento na rede semântica, unindo dois nós pelos respectivos IDs segundo um tipo de relacionamento segundo ID

10• f: fim de arquivo

Para exemplificar, considere o exemplo apresentado na seção semantic-relation, cujo nome é rede01.txt
