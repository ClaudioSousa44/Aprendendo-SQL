#Permite exibir todos os databases existentes
show databases;

#Cria um database
create database db_videolocadora_tarde_20231;

#Apaga um database
drop database db_videolocadora_tarde_20231;

#Permite selecionar o db que sera utilizado
use db_videolocadora_tarde_20231;

#Mostra todas as tabelas
show tables;

#TABELA: CLASSIFICAÇÃO
create table tbl_classificacao (
	id int not null auto_increment primary key,
    sigla varchar(2) not null,
    nome varchar(45) not null,
    descricao varchar(80) not null,
    
    unique index(id)

);

#TABELA: GENERO
CREATE TABLE tbl_genero (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(45) NOT NULL,
    
    UNIQUE INDEX (id)

);

#TABELA: SEXO
CREATE TABLE tbl_sexo (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sigla VARCHAR(5) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    
    UNIQUE INDEX (id)
);

#TABELA: NACIONALIDADE
CREATE TABLE tbl_nacionalidade (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome  VARCHAR(45) NOT NULL,
    
    UNIQUE INDEX(id)
);

desc tbl_nacionalidade;

#------------------------------------------------------------ comando para alterar  uma tabela --------------------------------------------------------#

#add column - Adiciona uma nova coluna na tabela;
ALTER TABLE tbl_nacionalidade 
 add column descricao varchar(50) not null;

alter table tbl_nacionalidade
 add column teste int , 
 add column teste2 varchar(10) not null;

#Drop column - exclui uma coluna da tabela
alter table tbl_nacionalidade
 drop column teste2;

#Altera as caracteristicas de uma coluna
ALTER TABLE tbl_nacionalidade
 modify column teste varchar(5) not null;
 
 #change -> Permirte alterar a escrita e a sua estrutura
 alter table tbl_nacionalidade
	change teste teste_nacionalidade int not null;
    
#Exclui uma tabela do database
drop table tbl_nacionalidade;


#------------------------------ CRIANDO TABELAS COM FK -------------------------------------------- #
create table tbl_filme (
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_original varchar(100) not null,
    data_lancamento date not null,
    data_relancamento date,
    duracao time not null,
    foto varchar(150) not null,
    sinopse text not null,
    id_classificacao int not null,
    
    #É atribuido um nome ai processo de criar a fk 
    constraint FK_Classificacao_filme
    #É o atributo desta tabela que sera a fk
    foreign key (id_classificacao)
    #Especifica de onde irá vir a fk
    references tbl_classificacao (id),
    
    unique index (id)
);

desc tbl_filme;

#TABELA: FILME_GENERO
create table tbl_filme_genero (
	id int not null auto_increment,
    id_filme int not null,
    id_genero int not null,
    
    #Relacionamneto de filme_filmeGenero
    constraint fk_filme_filmeGenero
    foreign key (id_filme)
    references tbl_filme (id),
    
    #Relacionamento: Genero_FilmeGenero
    constraint fk_genero_genero
    foreign key (id_genero)
    references tbl_genero (id),
    
    unique index (id),
    primary key (id)
);

drop table tbl_filme_genero;

show tables;

desc tbl_filme_genero;

drop table tbl_genero;

alter table tbl_filme_genero
	drop foreign key fk_filme_filmeGenero;
    
alter table tbl_filme_genero
	add constraint fk_filme_filmeGenero
    foreign key (id_filme)
    references tbl_filme (id);
    
#TABELA: FILME_AVALIACAO
create table tbl_filme_avaliacao (
	id int not null auto_increment primary key,
    nota float not null,
    comentario varchar(300),
    id_filme int not null,
    
    constraint fk_filme_avaliacao
    foreign key (id_filme)
    references tbl_filme (id),
    
    unique index (id)
);

#TABELA: DIRETOR
create table tbl_diretor(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    biografia text not null,
    foto varchar(100) not null,
    id_sexo int not null,
    
    constraint fk_sexo_diretor
    foreign key (id_sexo)
    references tbl_sexo (id),
    
    unique index (id) 
);

#TABELA: FILME_DIRETOR
create table tbl_filme_diretor(
	id int not null auto_increment primary key,
    id_filme int not null,
    id_diretor int not null,
    
    constraint fk_filme_filmeDiretor
    foreign key (id_filme)
    references tbl_filme (id),
    
    constraint fk_diretor_filmeDiretor
    foreign key (id_diretor)
    references tbl_diretor (id),
    
    unique index (id)
);

#TABELA: DIRETOR_NACIONALIDADE
create table tbl_diretor_nacionalidade(
	id int not null auto_increment primary key,
    id_nacionalidade int not null,
    id_diretor int not null,
    
    constraint fk_nacionalidade_diretorNacionalidade
    foreign key (id_nacionalidade)
    references tbl_nacionalidade (id),
    
    constraint fk_diretor_diretorNacionalidade
    foreign key (id_diretor)
    references tbl_diretor (id),
    
    unique index (id)
);

#TABELA: ATOR
create table tbl_ator(
	id int not null auto_increment primary key,
	nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    data_falecimento date,
    foto varchar(150) not null,
    biografia text not null,
    id_sexo int not null,
     
	constraint fk_sexo_ator
    foreign key (id_sexo)
    references tbl_sexo (id),
    
    unique index (id)
);

#TABELA: ATOR_NACIONALIDADE
create table tbl_ator_nacionalidade (
	id int not null auto_increment primary key,
    id_ator int not null,
    id_nacionalidade int not null,
    
    constraint fk_ator_atorNacionalidade
    foreign key (id_ator)
    references tbl_ator (id),
    
    constraint fk_nacionalidade_atorNacionalidade
    foreign key (id_nacionalidade)
    references tbl_nacionalidade (id),
    
    unique index (id)

);

#TABELA: FILME_ATOR
create table tbl_filme_ator(
	id int not null auto_increment primary key,
    id_filme int not null,
    id_ator int not null,
     
	constraint fk_filme_filmeAtor
    foreign key (id_filme)
    references tbl_filme (id),
    
    constraint fk_ator_filmeAtor
    foreign key (id_ator)
    references tbl_ator (id),
    
    unique index (id)
);

show tables;

#INSERTS

#TABELA GENERO
insert tbl_genero (nome) values ('Policial');
insert tbl_genero (nome) values ('Drama');
insert tbl_genero (nome) values ('Comédia'), 
								('Romance'),
                                ('Aventura'),
                                ('Animação'),
                                ('Musical')
                                ;
                                
insert tbl_genero (nome) values ('Ação'),
								('Fantasia'),
                                ('Suspense');

select * from tbl_genero;

#UPDATE
update tbl_genero set nome = 'Comedia' where id = 3;

desc tbl_classificacao;

#TABELA CLASSIFICACAO
insert into tbl_classificacao (sigla,nome,descricao) values ('L', 'Livre', 'Não expõe crianças a  conteúdo poyencialmente prejudiciais'),
													   ('10', 'Não recomendado para menores de 10 anos', 'Conteúdo violento ou linguagem inapropriada para crianças'),
                                                       ('12', 'Não recomendado para menores de 12 anos', 'As cenas podem conter agressão física, consumo de drogas e insinuação sexual.'),
                                                       ('14', 'Não recomendado para menores de 14 anos', 'Conteúdo mais violento e/ou de linguagem sexual mais acentuada.' ),
                                                       ('16', 'Não recomendado para menores de 16 anos', 'Conteúdo mais violentos ou com conteúdo sexual mais intenso.'),
													   ('18', 'Não recomendado para menores de 18 anos', 'Conteúdos violentos e sexuais extremos. ') 
                                                       ;
                                                       
select * from tbl_classificacao;

desc tbl_filme;
#INSERT
## TABELA FILME
insert into tbl_filme (
						nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto,
                        sinopse,
                        id_classificacao
                        )values (
                        'O PODEROSO CHEFÃO',
                        'The Godfather',
                        '1972-03-24',
                        '2022-02-04',
                        '02:55:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/93/20/20120876.jpg',
                        'Don Vito Corleone (Marlon Brando) é o chefe de uma "família" de Nova York que está feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). 
                        Porém, durante a festa, Bonasera (Salvatore Corsitto) é visto no escritório de Don Corleone pedindo "justiça", vingança na verdade contra membros de uma quadrilha,
                        que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, 
                        que maltrataram a filha de Bonasera não serão mortos, pois ela também não foi, mas serão severamente castigados. Vito porém deixa claro que ele pode chamar Bonasera algum dia para devolver o "favor".
                        Do lado de fora, no meio da festa, está o terceiro filho de Vito, Michael (Al Pacino), um capitão da marinha muito decorado que há pouco voltou da 2ª Guerra Mundial. Universitário educado, sensível e
                        perceptivo, ele quase não é notado pela maioria dos presentes, com exceção de uma namorada da faculdade, Kay Adams (Diane Keaton), que não tem descendência italiana mas que ele ama. Em contrapartida há 
                        alguém que é bem notado, Johnny Fontane (Al Martino), um cantor de baladas românticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone já o tinha ajudado, quando Johnny ainda estava
                        em começo de carreira e estava preso por um contrato com o líder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o líder
                        da banda e ofereceu 10 mil dólares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga,
                        e após uma hora ele assinou a liberação por apenas mil dólares, mas havia um detalhe: nas "negociações" Luca colocou uma arma na cabeça do líder da banda. Agora, no meio da
                        alegria da festa, Johnny quer falar algo sério com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do estúdio, Jack Woltz 
                        (John Marley), nem pensa em contratá-lo. Nervoso, Johnny começa a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguirá o almejado papel. Enquanto a festa c
                        ontinua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo terá um emprego mas nada muito importante, 
                        e que os "negócios" não devem ser discutidos na sua frente. Os verdadeiros problemas começam para Vito quando Sollozzo (Al Lettieri), um gângster que tem apoio de uma família rival, encabeçada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reunião com Vito, Sonny e outros, conta para a família que ele pretende estabelecer um grande esquema de vendas de narcóticos em Nova York, mas exige permissão e proteção política de Vito para agir.
                        Don Corleone odeia esta idéia, pois está satisfeito em operar com jogo, mulheres e proteção, mas isto será apenas a ponta do iceberg de uma mortal luta entre as "famílias".',
                        10
                        );
                        
insert into tbl_filme (
						nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto,
                        sinopse,
                        id_classificacao
                        )values (
                        'FORREST GUMP - O CONTADOR DE HISTÓRIAS',
                        'Forrest Gump',
                        '1994-12-07',
                        null,
                        '02:20:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/30/21/19874092.jpg',
                        'Quarenta anos da história dos Estados Unidos, vistos pelos olhos de Forrest Gump (Tom Hanks), um rapaz com QI abaixo da média e boas intenções. Por obra do acaso, ele consegue participar de momentos cruciais, como a Guerra do Vietnã e Watergate, mas continua pensando no seu amor de infância, Jenny Curran.',
                        10
                        );
                        
insert into tbl_filme (
						nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto,
                        sinopse,
                        id_classificacao
                        )values (
                        'O REI LEÃO',
                        'The Lion King',
                        '1994-07-08',
                        '2011-08-26',
                        '01:29:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/84/28/19962110.jpg',
                        'Clássico da Disney, a animação acompanha Mufasa (voz de James Earl Jones), o Rei Leão, e a rainha Sarabi (voz de Madge Sinclair), apresentando ao reino o herdeiro do trono, Simba (voz de Matthew Broderick). O recém-nascido recebe a bênção do sábio babuíno Rafiki (voz de Robert Guillaume), mas ao crescer é envolvido nas artimanhas de seu tio Scar (voz de Jeremy Irons), o invejoso e maquiavélico irmão de Mufasa, que planeja livrar-se do sobrinho e herdar o trono.',
                        7
                        );
                        
insert into tbl_filme (
						nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto,
                        sinopse,
                        id_classificacao
                        )values (
                        'À ESPERA DE UM MILAGRE',
                        'The Green Mile',
                        '2000-03-10',
                        null,
                        '03:09:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/66/66/20156966.jpg',
                        '1935, no corredor da morte de uma prisão sulista. Paul Edgecomb (Tom Hanks) é o chefe de guarda da prisão, que temJohn Coffey (Michael Clarke Duncan) como um de seus prisioneiros. Aos poucos, desenvolve-se entre eles uma relação incomum, baseada na descoberta de que o prisioneiro possui um dom mágico que é, ao mesmo tempo, misterioso e milagroso.',
                        10
                        );
                        
                        
insert into tbl_filme (
						nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto,
                        sinopse,
                        id_classificacao
                        )values (
                        'BATMAN - O CAVALEIRO DAS TREVAS',
                        'The Dark Knight',
                        '2008-07-18',
                        null,
                        '02:32:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg',
                        'Após dois anos desde o surgimento do Batman (Christian Bale), os criminosos de Gotham City têm muito o que temer. Com a ajuda do tenente James Gordon (Gary Oldman) e do promotor público Harvey Dent (Aaron Eckhart), Batman luta contra o crime organizado. Acuados com o combate, os chefes do crime aceitam a proposta feita pelo Coringa (Heath Ledger) e o contratam para combater o Homem-Morcego.',
                        9
                        );
                        
                        
insert into tbl_filme (
						nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto,
                        sinopse,
                        id_classificacao
                        )values (
                        'VINGADORES: ULTIMATO',
                        'Avengers: Endgame',
                        '2019-04-25',
                        '2019-07-11',
                        '03:01:00',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',
                        'Em Vingadores: Ultimato, após Thanos eliminar metade das criaturas vivas em Vingadores: Guerra Infinita, os heróis precisam lidar com a dor da perda de amigos e seus entes queridos. Com Tony Stark (Robert Downey Jr.) vagando perdido no espaço sem água nem comida, o Capitão América/Steve Rogers (Chris Evans) e a Viúva Negra/Natasha Romanov (Scarlett Johansson) precisam liderar a resistência contra o titã louco.',
                        9
                        );                        
                        
select * from tbl_filme;

#INSERT
## TABELA DE RELAÇÃO ENTRE FILME E GENERO
### poderoso chefao
insert into tbl_filme_genero (id_filme, id_genero) values (1, 1),
                                                          (1, 2); 

### CONTADOR DE HISTORIAS                                                         
insert into tbl_filme_genero (id_filme, id_genero) values (2, 4),
                                                          (2, 2),
                                                          (2, 3); 

###REI LEAO
insert into tbl_filme_genero (id_filme, id_genero) values (3, 5),
                                                          (3, 6),
                                                          (3, 7); 
                                                          
### A ESPERA DE UM MILAGRE                                                          
insert into tbl_filme_genero (id_filme, id_genero) values (4, 1),
                                                          (4, 9); 

### Batman - O Cavaleiro Das Trevas
insert into tbl_filme_genero (id_filme, id_genero) values (5, 8),
                                                          (5, 10); 	
                                                          
###  Vingadores: Ultimato                                                        
insert into tbl_filme_genero (id_filme, id_genero) values (6, 8),
                                                          (6, 5),
                                                          (6, 9); 	


#INSERT TBL SEXO 														
insert into tbl_sexo (sigla, nome) values('F', 'Feminino'),
                                         ('M', 'Masculino');	
                                         
#INSERT TBL ATOR
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'MARLON BRANDO',
                       null,
                       '1924-04-03',
                       '2004-07-01',
                       'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/51/54/20040663.jpg',
                       '- Trabalhou como ascensorista de elevador em uma loja por 4 dias, antes de se tornar famoso.- Possui uma ilha particular no oceano Pacífico, na Polinésia, desde 1966.- O Oscar que ganhou por "Sindicato dos Ladrões" foi roubado de sua casa, com o ator tendo solicitado à Academia de Artes e Ciências Cinematográficas a reposição da estatueta, em 1970.- Recusou o Oscar recebido por "O Poderoso Chefão", em protesto pelo modo como os Estados Unidos e, especialmente, Hollywood vinham discriminando os índios nativos do país. Brando não compareceu à cerimônia de entrega do Oscar e enviou em seu lugar a atriz Sacheen Littlefeather, que subiu ao palco para receber a estatueta do ator como se fosse uma índia verdadeira, divulgando seu protesto- Em determinado momento das filmagens de "A Cartada Final", se recusava a estar no mesmo set que o diretor Frank Oz.- Possui uma estrela na Calçada da Fama, localizada em 1777 Vine Street.',
                       2
                       );

insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'AL PACINO',
                       null,
                       '1940-04-25',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/19/03/19/18/33/1337912.jpg',
                       '- É um grande fã de ópera;- É um dos poucos astros de Hollywood que nunca casou;- Foi preso em janeiro de 1961, acusado de carregar consigo uma arma escondida;- Recusou o personagem Han Solo, da trilogia original de "Star Wars";- Foi o primeiro na história do Oscar a ser indicado no mesmo ano nas categorias de melhor ator e melhor ator coadjuvante.',
                       2
                       );
                       
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'James Edmund Caan',
                       'JAMES CAAN',
                       '1940-03-26',
                       '2022-07-06',
                       'https://br.web.img3.acsta.net/c_310_420/pictures/15/06/09/21/29/576102.jpg',
                       'James Caan foi um ator americano, mais conhecido por seu papel Sonny Corleone no clássico O Poderoso Chefão, dirigido por Francis Coppola. Em vida, Caan recebeu diversos prêmios, incluindo quatro indicações ao Golden Globes, uma ao Emmy e uma ao Oscar. Além disso, em 1978 Caan ganhou uma estrela na calçada da fama de Hollywood.Caan nasceu no Bronx, em Nova York e cresceu no Queens. O ator estudou na Universidade de Michigan e se transferiu para a Hempstead, sem colar grau, mas entre seus colegas de turma estavam Coppola e a atriz Lainie Kazan. Durante este tempo, Caan se interessou pela atuação e foi aceito na escola de teatro Neighborhood Playhouse, onde estudou por cinco anos. Seus primeiros trabalhos foram em El Dorado, Countdown e Caminhos Mal Traçados, até participar de O Poderoso Chefão com o personagem que se tornaria sua assinatura. Por sua interpretação de Sonny Corleone, Caan foi indicado ao Oscar e o Globo de Ouro de melhor ator coadjuvante. Entre outros papéis importantes, na década de 70 é possível citar os filmes Licença Para Amar até a Meia Noite, Rollerball - Os Gladiadores do Futuro, Uma Ponte Longe Demais e Raízes da Ambição. Durante as próximas décadas, Caan começou a participar de projetos de forma mais esporadicamente. Seus trabalhos notáveis depois deste período foram: Jardins de Pedra, Louca Obsessão, Pura Adrenalina, Caminho Sem Volta, Dogville e Um Duende em Nova York. ',
                       2
                       );                       
                       
 insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Thomas Jeffrey Hanks',
                       'TOM HANKS',
                       '1956-07-09',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/18/08/08/18/47/1167635.jpg',
                       'Tom Hanks iniciou a carreira no cinema aos 24 anos, com um papel no filme de baixo orçamento Trilha de Corpos. Logo migrou para a TV, onde estrelou por dois anos a série Bosom Buddies. Nela passou a trabalhar com comédia, algo com o qual não estava habituado, rendendo convites para pequenas participações nas séries Táxi, Caras & Caretas e Happy Days.

                        Em 1984, veio seu primeiro sucesso no cinema: a comédia Splash - Uma Sereia em Minha Vida, na qual era dirigido por Ron Howard e contracenava com Daryl Hannah. Em seguida vieram várias comédias, entre elas A Última Festa de Solteiro (1984), Um Dia a Casa Cai (1986) e Dragnet - Desafiando o Perigo (1987), tornando-o conhecido do grande público.

                         Com Quero Ser Grande (1988) Hanks obteve sua primeira indicação ao Oscar de melhor ator. Apesar de consagrado como comediante, aos poucos passou a experimentar outros gêneros. Em 1993 surpreendeu em Filadélfia como um advogado homossexual que luta na justiça contra sua demissão, motivada por preconceito devido a ele ser portador do vírus da AIDS. Pelo papel conquistou seu primeiro Oscar.

                         Já no ano seguinte Hanks ganharia sua segunda estatueta dourada, repetindo um feito apenas obtido por Spencer Tracy, quase 60 anos antes. Forrest Gump - O Contador de Histórias foi sucesso de público e crítica, ganhando seis Oscar.

                          Estabelecido como um dos maiores astros de Hollywood, Hanks passou a emendar um sucesso atrás do outro: Apollo 13 - Do Desastre ao Triunfo (1995), Toy Story (1995), O Resgate do Soldado Ryan (1998), Mens@gem Para Você (1998), Toy Story 2 (1999), À Espera de um Milagre (1999), Náufrago (2000), Prenda-me Se For Capaz (2002) e Estrada para Perdição (2002).

                         Em 1996, resolveu se dedicar à sua estreia na direção. O resultado foi The Wonders - O Sonho Não Acabou, divertida comédia que rendeu a contagiante música "That Thing You Do!". Hanks voltaria a trabalhar como diretor em episódios das séries de TV Da Terra à Lua (1998) e Band of Brothers (2001) e também na comédia romântica Larry Crowne - O Amor Está de Volta (2011).

                         Em 2004, o ator encampou a ideia de interpretar vários personagens na animação O Expresso Polar, dirigida pelo colega Robert Zemeckis. Usando o método de captura de movimento, Hanks interpretou seis personagens de idades variadas.

                         Um de seus personagens mais famosos é o simbologista Robert Langdon, criado pelo autor Dan Brown. Hanks o interpretou em dois filmes, O Código Da Vinci (2006) e Anjos e Demônios (2009).',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Gary Alan Sinise',
                       'GARY SINISE',
                       '1955-03-17',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/92/45/36/20200745.jpg',
                       'Gary Alan Sinise é um ator norte-americano, diretor de cinema e músico. Durante sua carreira, ganhou vários prêmios, incluindo um Emmy e um Globo de Ouro, além de ser nomeado para um Oscar.',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Robin Virginia Gayle Wright',
                       'ROBIN WRIGHT',
                       '1966-04-08',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/19/11/05/01/50/2018682.jpg',
                       'Robin Wright nasceu em Dallas, Texas, filha de Gayle Gaston, uma vendedora de cosméticos, e Freddie Wright, funcionário de uma empresa farmacêutica. A atriz ficou famosa por seus papeis em House of Cards, Mulher-Maravilha, Corpo Fechado e Forrest Gump - O Contador de Histórias.',
                       1
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Manoel Garcia Junior',
                       'GARCIA JÚNIOR',
                       '1967-03-02',
                       null,
                       'https://br.web.img2.acsta.net/c_310_420/pictures/14/01/16/13/52/556410.jpg',
                       'Manoel "Manny" Garcia Júnior nasceu em 1967, na cidade de São Paulo, filho dos dubladores Garcia Neto e Dolores Machado. Sua primeira participação na televisão foi aos 2 anos no programa de TV de Omar Cardoso, um astrólogo, em 1969, onde seu pai era produtor, e o colocou para fazer parte do programa como um cupido. Tendo passado a infância em teatros, estúdios de rádio e de dublagem onde os pais trabalhavam, aos 10 anos entrou para o ramo na BKS, porque o dublador que fazia a voz do Pica-Pau, Olney Cazarré, teve que ir ao Rio de Janeiro, para fazer parte de uma novela, e Garcia Neto, ao assumir a direção, testou o filho no papel. Em 1982 Garcia Júnior e seus pais se mudaram para o Rio de Janeiro, e eles passaram a dublar na Herbert Richers, na Telecine e na VTI Rio.[5][6] Em 1985 Garcia Júnior passou a fazer o personagem título da serie He-Man, um de seus papéis de mais destaques. Em 1988 García Júnior passou a fazer a voz do ator Arnold Schwarzenegger. Em 1991 Garcia Júnior passou a traduzir e dirigir dublagens inicialmente na Herbert Richers. Em 1994 Garcia Júnior se tornou diretor de criação da parte brasileira da Disney e passou a trabalhar no estúdio de dublagem Delart. Em 1996 Garcia Neto, o pai de Garcia Júnior, faleceu de um câncer. Em 1999 Garcia Júnior dirigiu o longa metragem Toy Story 2, dando sequência a Toy Story, que foi dirigido por seu pai, Garcia Neto. Em 2004 Dolores Machado, a mãe de García Júnior, se aposentou da dublagem. Em 2005 Garcia Júnior parou de dublar na Herbert Richers, passando a dublar mais na Delart. Em 2008 Garcia Júnior se afastou um pouco da dublagem, e passou a se dedicar apenas para sua trabalhos da Disney. Em 2010 Garcia Júnior dirigiu a dublagem de Toy Story 3, onde dublou o personagem Espeto. Em 2011 Garcia Júnior foi demitido de seu cargo na Disney. Em 2012 García Júnior voltou a dublar mais na Double Sound, e na Wan Macher, mas principalmente na Delart, e faz isso até hoje em dia.',
                       2
                       ); 
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'MATTHEW BRODERICK',
                       'MATTHEW BRODERICK',
                       '1962-03-21',
                       null,
                       'https://br.web.img2.acsta.net/c_310_420/pictures/19/07/02/22/47/0236519.jpg',
                       'Broderick nasceu em Nova York, filho de Patricia Biow, uma dramaturga, atriz e pintora, e de James Joseph Broderick, um ator.[1][2] A mãe de Broderick era judia e seu pai, um católico de ascedência irlandesa.[3][4][5] Broderick frequentou a escola primária City & Country School e cursou o ensino médio na Walden School. Depois da morte de sua mãe, suas pinturas foram exibidas na Tibor de Nagy Gallery em Nova York',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Todd Jones',
                       'JAMES EARL JONES',
                       '1931-01-17',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/55/34/20040970.jpg',
                       '- Do signo de Capricórnio;- Possui descendência africana, indígena e irlandesa;- Foi criado pelos avós maternos. Seus pais, Ruth Connolly and Robert Earl Jones, se separaram pouco antes de seu nascimento;- Começou a ter aulas de atuação para curar sua gagueira;- Também para melhorar sua dicção, começou a escrever poesias e contava com o apoio dos professores, que permitiam que ele as lesse em sala de aula;- É um veterano do exército dos Estados Unidos;- É membro da NRA (Associação Nacional de Rifles da América);- Foi casado com a atriz Julienne Marie, de quem se separou em 1972. Se casou novamente dez anos depois, em 82, com Cecilia Hart, com quem teve um filho;- Foi o primeiro afro-descendente a interpretar o presidente dos EUA. Foi no telefilme The Man, de 1972;- Conhecido por sua voz marcante, tendo conquistado notoriedade por dublar Darth Vader em Star Wars e Mufasa ',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'MICHAEL CLARKE DUNCAN',
                       'Michael Duncan',
                       '1957-12-10',
                       '2012-09-03',
                       'https://br.web.img3.acsta.net/c_310_420/pictures/14/09/06/19/41/147683.jpg',
                       'Michael Clarke Duncan é conhecido pela atuação em À Espera de um Milagre, que lhe rendeu indicações ao Oscar e ao Globo de Ouro de Melhor Ator Coadjuvante. Fez sua estreia nos cinemas em 1995, com um papel não creditado em Sexta-Feira em Apuros. O primeiro trabalho de destaque viria três anos depois com Armageddon. Agradou tanto que Bruce Willis recomendou que Frank Darabont contratasse ele para À Espera de um Milagre, em 1999.Muitas vezes tratado como Big Mike, por causa da altura de 1,96 m, o ator se destacou ainda em Meu Vizinho Mafioso, Planeta dos Macacos, O Escorpião Rei e A Ilha. Participou também de três adaptações dos quadrinhos: O Demolidor, Sin City - A Cidade do Pecado e Lanterna Verde. Robert Rodriguez contava com o retorno dele para Sin City 2: A Dame to Kill For, algo que infelizmente não irá mais acontecer.Na TV',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'David Bowditch Morse',
                       'DAVID MORSE',
                       '1953-10-11',
                       null,
                       'https://br.web.img2.acsta.net/c_310_420/pictures/15/02/25/18/50/212119.jpg',
                       'David Morse é filho de Jacquelyn (professora) e de Charles Morse (encarregado de vendas). Tem três irmãs. Casou-se com Susan Duff a 19 de junho de 1982. O casal teve três filhos e reside atualmente em Filadélfia, Pensilvânia.',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Christian Charles Philip Bale',
                       'CHRISTIAN BALE',
                       '1974-01-30',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/24/18/43/126776.jpg',
                       'Caçula de três irmãs mais velhas, filho de um piloto de aviação comercial e de uma dançarina de circo, Bale começou a atuar por influência de uma delas. Pouca gente recorda que este ator inglês é o menino Jim, que tocou corações em Império do Sol (1987), de Steven Spielberg. Para ganhar o papel, derrotou cerca de quatro mil candidatos e sua atuação ainda rendeu prêmios.Mesmo tendo começado cedo (aos 9 anos fez seu primeiro comercial de cereais), foi somente com Psicopata Americano (2000) que ganhou mais notoriedade no papel de Patrick Bateman, que seria, incialmente, de Leonardo DiCaprio.Sua dedicação ao trabalho é reconhecida e sua "entrega" para viver Trevor em O Operário (2004), quando emagreceu cerca de 30 kg, foi considerada chocante demais.',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Heathcliff Andrew Ledger',
                       'HEATH LEDGER',
                       '1979-04-04',
                       '2008-01-22',
                       'https://br.web.img2.acsta.net/c_310_420/pictures/18/08/16/19/43/2593099.jpg',
                       'Extremamente tímido, este australiano descendente de irlandeses e escoceses optou por atuar desde cedo. Mesmo com a rápida fama conquistada, em parte por sua beleza, ele procurou interpretar papéis que não explorassem este aspecto e conseguiu atuações marcantes em sua curta carreira. Premiado após sua morte pela atuação como Coringa, Ledger tem seu lugar marcado para sempre na história do cinema mundial. (RC)- Filho de Sally Ramshaw e Kim Ledger;- Descendente de irlandeses e escoceses;- Teve três irmãs: Catherine (Kate) Ledger, Olivia Ledger e Ashleigh Bell;- Seu nome e o da irmã mais velha, Kate Ledger, foram retirados dos personagens principais do romance "Wuthering Heights" de Emily Brontë;- Teve um canguru de esimação, achado por sua mãe quando ainda era filhote;- Na escola, era concentrado em atuar e nos esportes.',
                       2
                       );

insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Aaron Edward Eckhart',
                       'AARON ECKHART',
                       '1968-03-12',
                       null,
                       'https://br.web.img2.acsta.net/c_310_420/pictures/16/01/28/10/38/041658.jpg',
                       '- Comprou uma moto após aprender a dirigi-la nas filmagens de "Erin Brockovich, uma Mulher de Talento" (2000); - Tirou férias de três anos após completar o 2º grau para esquiar na França e surfar no Havaí.',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Robert John Downey Jr',
                       'ROBERT DOWNEY JR.',
                       '1965-04-04',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/18/06/29/00/35/0101925.jpg',
                       'Do céu ao inferno e ao céu novamente. Se alguém pensou no mito do pássaro fênix que renasce das cinzas, até que a comparação poderia se encaixar para definir este brilhante ator que já deu vida para personagens tão distantes em tempo e estilo, como Charles Chaplin (Chaplin - 1992) e Tony Stark (Homem de Ferro - 2008).Na ativa por mais de quatro décadas e dono de uma voz grave, afinada, Downey já dublou desenho animado (God, the Devil and Bob - 2000), se aventurou no mundo da música, em 2004, com o disco The Futurist (Sony) e fez bonito na televisão, onde faturou o Globo de Ouro, além de outros prêmios e indicações por Larry Paul, personagem do seriado Ally McBeal (2000 - 2002). Mas é no cinema que sua estrela parece brilhar mais intensamente. Tendo estreado aos cinco anos de idade, em 1970, dirigido pelo pai em Pound',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       ' Christopher Robert Evans',
                       'CHRIS EVANS',
                       '1981-06-13',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/19/59/2129500.jpg',
                       'Depois de uma infância e estudos ​​em Boston, Chris Evans decidiu ir para Nova York para tentar a sorte na comédia. Ele rapidamente consegue entrar na profissão, principalmente participando em séries de televisão (Boston Public). Sua carreira no cinema começou em 2001, em uma comédia para adolescentes (Não é Mais um Besteirol Americano). Mas sem ficar preso a apenas um gênero de filme, o ator vai para outras produções: trapaceia nas provas com Scarlett Johansson na comédia policial Nota Máxima (2004), interpreta o papel de Kim Basinger no thriller Celular - Um Grito de Socorro (2004) e seduz Jessica Biel em London (2005).',
                       2
                       );
                       
insert into tbl_ator (
                       nome,
                       nome_artistico,
                       data_nascimento,
                       data_falecimento,
                       foto,
                       biografia,
                       id_sexo
                       ) values (
                       'Mark Alan Ruffalo',
                       'MARK RUFFALO',
                       '1967-11-22',
                       null,
                       'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/20/02/3083743.jpg',
                       'Apesar de ter um pequeno papel em Ride With The Devil (1999), a primeira participação de destaque de Mark Ruffalo no cinema vem com o premiado drama Conte Comigo (2000). Ele conquista papéis importantes no thriller erótico Em Carne Viva (2003) e no drama Brilho Eterno de uma Mente Sem Lembranças (2004), antes de se lançar em comédias românticas como De Repente 30 (2004) e Dizem Por Aí... (2005). Ele retoma os dramas e suspenses com Zodíaco (2007) e Ensaio Sobre a Cegueira (2008). Em 2010, Martin Scorsese convida-o a atuar em Ilha do Medo, ao lado de Leonardo DiCaprio. Ele recebe sua primeira indicação ao Oscar como ator coadjuvante no drama Minhas Mães e Meu Pai (2010). Um grande passo para o reconhecimento popular vem com o papel de Hulk no grande sucesso Os Vingadores - The Avengers (2012), abrindo a porta para novas produções no papel do monstro gigantesco.',
                       2
                       );                       
		
select * from tbl_ator;
select * from tbl_nacionalidade;

##INSERT
#TBL NACIONALIDADES
insert into tbl_nacionalidade ( nome ) values ('Americano'),
                                              ('Brasileiro'),
                                              ('Francês'),
                                              ('Britânico'),
                                              ('Australiano')
                                              ;											
select * from tbl_ator_nacionalidade;
##INSERT
#TBL ATOR NACIONALIDADE
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (1,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (2,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (3,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (4,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (5,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (6,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (7,2);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (8,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (9,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (10,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (11,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (12,4),(12,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (13,5);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (14,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (15,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (16,1);
insert into tbl_ator_nacionalidade ( id_ator, id_nacionalidade) values (17,1);


##INSERT 
##TBL DIRETOR
desc tbl_diretor;
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'FRANCIS FORD COPPOLA',
                            'Francis F. Coppola',
                            '1939-04-07',
                            'Em 1969, fundou juntamente com George Lucas a produtora American Zoetrope, em São Francisco, tendo como primeiro projeto o filme THX 1138 (1970);- É tio do ator Nicolas Cage;- Pai da tambem diretora Sofia Coppola;- Foi assistente de direção de Roger Corman;- Graduado na Universidade da Califórnia (UCLA), a mesma dos diretores, George Lucas e Steven Spielberg.',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/35/21/99/19187501.jpg',
                            2
                            );
							
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Robert Lee Zemeckis',
                            'ROBERT ZEMECKIS',
                            '1952-05-14',
                            'Especialista em efeitos especiais, Robert Zemeckis é um dos partidários dos filmes do também diretor Steven Spielberg, que já produziu vários de seus filmes; - Trabalhando geralmente com seu parceiro de roteiros Bob Gale, os primeiros filmes de Robert apresentou ao público seu talento para comédias tipo pastelão, como Tudo por uma Esmeralda (1984); 1941 - Uma Guerra Muito Louca (1979) e, acrescentando efeitos muito especiais em Uma Cilada para Roger Rabbit (1988) e De Volta para o Futuro (1985); - Apesar destes filmes terem sidos feitos meramente para o puro entretenimento, com raros desenvolvimentos dos personagens ou mesmo com uma trama cuidadosa, eles são diversão na certa',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/57/81/20030814.jpg',
                            2
                            );
                            
                            
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Roger Allers',
                            null,
                            '1949-06-29',
                            'Nascido em Rye, Nova York, mas criado em Scottsdale, Arizona, Allers se tornou um fã de animação aos cinco anos de idade, depois de ver Peter Pan da Disney. Decidir o que ele queria buscar uma carreira na Disney e até mesmo trabalhar ao lado de Walt Disney, alguns anos mais tarde, ele foi enviado para a Disneylândia para um  kit de animação.[1] No entanto, Allers, até então um estudante do ensino médio, cresceu desanimado sobre a realização de seu sonho quando ele soube da morte de Walt Disney, em 1966.',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/54/06/20150846.jpg',
                            2
                            );
                            
                            
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Robert Ralph Minkoff',
                            'ROB MINKOFF',
                            '1962-08-11',
                            'Minkoff conseguiu sua grande chance quando ele dirigiu para a Walt Disney Animation Studios O Rei Leão (1994), ao lado de Roger Allers. Desde então, ele também dirigiu o seu primeiro filme live-action O Pequeno Stuart Little (1999), e Stuart Little 2 (2002), que eram uma mistura de live-action e animação por computador e depois alguns filmes totalmente em live-actions como A Mansão Assombrada (2003), O Reino Proibido (2008) e Flypaper (2011).',
                            'https://www.adorocinema.com/personalidades/personalidade-19647/fotos/',
                            2
                            );                            
                            
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Ferenc Árpád Darabont',
                            'FRANK DARABONT',
                            '1959-01-28',
                            'É o autor dos roteiros de "A Hora do Pesadelo 3", "A Mosca 2" e "Frankenstein de Mary Shelley".- Trabalhou como roteirista na série de TV norte-americana "O Jovem Indiana Jones".',
                            'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/95/95/20122149.jpg',
                            2
                            );  
                            
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Christopher Edward Nolan',
                            'CHRISTOPHER NOLAN',
                            '1970-07-30',
                            'Com apenas sete anos de idade, Christopher Nolan já se arriscava por trás das câmeras. Utilizando-se da câmera Super 8 do pai, ele realizou vários pequenos filmes estrelados por seus brinquedos. A vontade de dirigir não passou e ele acabou se tornando um importante realizador.Formou-se em literatura na Universidade de Londres, na mesma época em que começou a realizar filmes em 16mm. Seu curta "Larceny" foi exibido no Festival de Cinema de Cambridge em 1996.Nolan estreou na direção com Following (1998), mas foi Amnésia (2000) que chamou a atenção da grande público, abrindo seu caminho para o sucesso em Hollywood. Na sequência, comandou Al Pacino, Robin Williams e Hilary Swank em Insônia (2002).Em 2005, dirigiu o filme que mudou para sempre sua história: Batman Begins',
                            'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/26/15/33/118611.jpg',
                            2
                            );                            
                            
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Joseph Vincent Russo',
                            'JOE RUSSO',
                            '1971-07-08',
                            'Joseph Vincent Russo nasceu na cidade de Cleveland, nos EUA. Começou sua carreira como diretor de videoclipes, sempre ao lado do irmão Anthony Russo. Ambos se graduaram em cinema na Universidade de Iowa. Ao lado de Anthony, estreou como realizador de longas em L.A.X. 2194 (1994), telefilme da NBC.',
                            'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/17/01/231901.jpg',
                            2
                            );                            
                            
insert into tbl_diretor (
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            id_sexo
                            ) values (
                            'Anthony J. Russo',
                            'ANTHONY RUSSO',
                            '1970-02-03',
                            'Anthony Russo nasceu na cidade de Cleveland, nos EUA. Começou sua carreira como diretor de videoclipes, sempre ao lado do irmão Joe Russo. Ambos se graduaram em cinema na Universidade de Iowa. Ao lado de Joe, estreou como realizador de longas em L.A.X. 2194 (1994), telefilme da NBC.',
                            'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/16/59/250993.jpg',
                            2
                            );                            
                            
select * from tbl_diretor;
show tables;   
select * from tbl_diretor_nacionalidade ; 

##INSERT
#TBL DIRETOR NACIONALIDADE
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 1); 
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 2); 
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 3);
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 4);
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 5), (3,5); 
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (4 , 6);
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 7);
insert into tbl_diretor_nacionalidade (id_nacionalidade, id_diretor) values (1 , 8);    



##INSERT
#TBL FILME DIRETOR
desc tbl_filme_diretor;
insert into tbl_filme_diretor (id_filme, id_diretor) values (1,1);
insert into tbl_filme_diretor (id_filme, id_diretor) values (2,2);
insert into tbl_filme_diretor (id_filme, id_diretor) values (3,3) , (3,4);
insert into tbl_filme_diretor (id_filme, id_diretor) values (4,5);
insert into tbl_filme_diretor (id_filme, id_diretor) values (5,6);
insert into tbl_filme_diretor (id_filme, id_diretor) values (6,7),(6,8);
select * from tbl_filme_diretor;

##INSERT 
#TBL FILME ATOR
desc tbl_filme_ator;
insert into tbl_filme_ator ( id_filme, id_ator) values (1,1),(1,2),(1,3);
insert into tbl_filme_ator ( id_filme, id_ator) values (2,4),(2,5),(2,6);
insert into tbl_filme_ator ( id_filme, id_ator) values (3,7),(3,8),(3,9);
insert into tbl_filme_ator ( id_filme, id_ator) values (4,4),(4,10),(4,11);
insert into tbl_filme_ator ( id_filme, id_ator) values (5,12),(5,13),(5,14);
insert into tbl_filme_ator ( id_filme, id_ator) values (6,15),(6,16),(6,17);
select * from tbl_filme_ator;

##INSERT
#TBL FILME AVALIACAO
desc tbl_filme_avaliacao;
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
                                )values(
                                '5.0',
                                'O que mais ainda se pode falar deste filme?',
                                1
                                );

insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
                                )values(
                                '5.0',
                                'Woooollllll, um drama épico!!! Tom Hanks merecia o OSCAR de todos os tempos.... Forrest Gump é o filme! Mesmo sendo longo é incansável!',
                                2
                                );
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
                                )values(
                                '4.0',
                                'Uma das animações mais icônicas da Disney, O Rei Leão é tão lindamente animado quanto é emocionalmente impactante.',
                                3
                                );
                                
 insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
                                )values(
                                '3.5',
                                'Muito emocionante. Quase chorei quando o ratinho morreu. Como de costume, Tom Hanks arrasando e além dele, todas as demais atuações foram boas, destaque é claro para o Michel Clark Duncan.',
                                4							
                                );                               
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
                                )values(
                                '5.0',
                                'o melhor filme q eu ja vi mais assim eu gosto desse filme q ele tileva com o suspense ate o final!o filme e otimo!mais a maior pena e q o Heath Ledger morreu gostaria de ver a sequencia com ele.',
                                5
                                );                                


insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
                                )values(
                                '4.0',
                                'Mais drama, mais intensidade dos conflitos, mas não, necessariamente, menos ação nem menos efeitos. O filme é mais ambicioso.',
                                6
                                );
 
select * from tbl_filme order by nome, data_lancamento desc;

select ucase(tbl_filme.nome) as nome from tbl_filme;

select ucase(tbl_filme.nome) as nome,
       lcase(tbl_filme.nome_original) as nome_original,
				length(tbl_filme.nome) as qtde_caracteres,
				concat('Filme: ', tbl_filme.nome) as nome_formatado
 from tbl_filme;
 
 show databases;
 use db_videolocadora_tarde_20231;
 desc tbl_filme;
 alter table tbl_filme 
		add column valor_unitario float;
        
update tbl_filme set valor_unitario = 37.37 where id = 2;
select * from tbl_filme;

select min(valor_unitario) from tbl_filme;
select max(valor_unitario) from tbl_filme;
select round(avg(valor_unitario), 2) from tbl_filme;
select round(sum(valor_unitario), 2) as total from tbl_filme;

##Calculos matematicos
select tbl_filme.nome, tbl_filme.foto,
		concat('R$ ' , tbl_filme.valor_unitario) as valor_unitario ,
		concat( 'R$ ' , round((tbl_filme.valor_unitario - ((tbl_filme.valor_unitario * 10) / 100)), 2)) as valor_desconto
 from tbl_filme;

 ##Operadores de comparação
 # like
 # is
 
 select tbl_filme.nome, tbl_filme.foto, tbl_filme.valor_unitario from tbl_filme where tbl_filme.valor_unitario > 40 order by tbl_filme.valor_unitario desc;
 
 ##Operador lógico

#is null = retorna os registros nulos
#is not null = retorna os registros que não são nulos
 select tbl_filme.nome, tbl_filme.foto, tbl_filme.valor_unitario from tbl_filme where tbl_filme.valor_unitario <> 40 OR tbl_filme.valor_unitario is null;
 

 
 select * from tbl_filme where tbl_filme.valor_unitario >= 40 and  tbl_filme.valor_unitario <= 50;
  select * from tbl_filme where tbl_filme.valor_unitario between 40 and 50;
 select * from tbl_filme where tbl_filme.valor_unitario is null;
 select * from tbl_filme  where tbl_filme.valor_unitario like 37.37;
 
 
 ## FORMATANDO DATA E HORA
 select curdate() as data_atual;
 select current_date() as data_atual;
 
 select curtime() as hora_atual;
 select current_time() as hora_atual;
 
 select current_timestamp() as data_hora_atual;
 
 ## Formatando a hora
 select time_format(curtime(), '%H') as hora_formatada;
select time_format(curtime(), '%i') as hora_formatada;
select time_format(curtime(), '%s') as hora_formatada;
select time_format(curtime(), '%H:%i') as hora_formatada;

select hour(curtime()) as hora_formatada;
select minute(curtime()) as hora_formatada;
select second(curtime()) as hora_formatada;


## Formatando a data

select date_format(curdate(), '%d') as data_formata; # -> retorna o dia  
select date_format(curdate(), '%m') as data_formata; # -> retorna o mes em numeral
select date_format(curdate(), '%M') as data_formata; # -> retorna o mes por extenso
select date_format(curdate(), '%y') as data_formata; # -> retorna o ano com 2 digitos
select date_format(curdate(), '%Y') as data_formata; # -> retorna o ano com 4 digitos
select date_format(curdate(), '%w') as data_formata; # -> retorna o numeral do dia da semana   
select date_format(curdate(), '%W') as data_formata; # -> retorna o dia da semana por extenso        

select day(curdate()) as data_formata; # -> retorna o dia 
select month(curdate()) as data_formata;
select year(curdate()) as data_formata;

select date_format(curdate(), '%d/%m/%Y') as data_br;

select date_format(str_to_date('05/07/2020', '%d/%m/%Y'), '%Y-%m-%d') as data_universal;

select datediff('2023-05-24', '2023-05-01') as qtde_dias;

select timediff('16:15:00' , '10:05:01') as qtde_tempo,
 hour(timediff('16:15:00' , '10:05:01')) * 5 as valor_pagar,
 subtime(timediff('17:00:00','13:30:00'), '00:15:00') as novo;
 
 select md5('senai') as dados;
 
 ##RELACIONAMENTO ENTRE TABELAS
 
 ### RELACIONAMENTO PELO WHERE
 #Exemplo 1
select tbl_ator.nome, tbl_ator.data_nascimento,
		tbl_sexo.sigla

from tbl_ator, tbl_sexo

where tbl_sexo.id = tbl_ator.id_sexo

#Exmplo 2
select tbl_ator.nome, tbl_ator.foto, tbl_ator.biografia,
 tbl_sexo.sigla, tbl_sexo.nome,
 tbl_nacionalidade.nome
 
 from tbl_ator, tbl_sexo, tbl_nacionalidade, tbl_ator_nacionalidade
 
 where tbl_sexo.id = tbl_ator.id_sexo and
		tbl_ator.id = tbl_ator_nacionalidade.id_ator and
        tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade;



 ### RELACIONAMENTO PELO FROM
 ##Exemplo 01
select tbl_ator.nome, tbl_ator.data_nascimento,
	   tbl_sexo.sigla
from tbl_ator
			inner join tbl_sexo
				on tbl_sexo.id = tbl_ator.id_sexo;
                
## Exemplo 02
select tbl_ator.nome, tbl_ator.foto, tbl_ator.biografia,
	   tbl_sexo.sigla, tbl_sexo.nome,
       tbl_nacionalidade.nome
from tbl_ator
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo
		inner join tbl_ator_nacionalidade
			on tbl_ator.id = tbl_ator_nacionalidade.id_ator
		inner join tbl_nacionalidade
			on tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade;
            
            
## ATIVIDADE
select tbl_filme.nome as nome_filme, tbl_filme.data_lancamento, tbl_filme.sinopse,
	   tbl_genero.nome as genero,
       tbl_ator.nome as nome_ator, tbl_ator.biografia,
       tbl_nacionalidade.nome as nacionalidade,
       tbl_sexo.nome as sexo
from tbl_filme
		inner join tbl_filme_genero
			on tbl_filme_genero.id_filme = tbl_filme.id
		inner join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		inner join tbl_filme_ator
			on tbl_filme_ator.id_filme = tbl_filme.id
		inner join tbl_ator
			on tbl_ator.id = tbl_filme_ator.id_ator
		inner join tbl_ator_nacionalidade
			on tbl_ator_nacionalidade.id_ator = tbl_ator.id
		inner join tbl_nacionalidade
			on tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo
		order by tbl_filme.nome, tbl_ator.nome;
        
insert into tbl_classificacao(sigla, nome, descricao) values ('NA', 'Não aplicavel', 'Não aplicavel a nenhum filtro');
desc tbl_classificacao;

select tbl_filme.nome as nome_filme, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		inner join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;
            
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero
	from tbl_filme
		inner join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		inner join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero;

 ##LEFT JOIN
select tbl_filme.nome as nome_filme, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		left join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;
            
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		left join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		left join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		inner join tbl_classificacao
			on tbl_filme.id_classificacao = tbl_classificacao.id;


##RIGHT JOIN
select tbl_filme.nome as nome_filme, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		right join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;
            
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		right join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		right join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		left join tbl_classificacao
			on tbl_filme.id_classificacao = tbl_classificacao.id;
		
##FULL JOIN
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		left join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		left join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		inner join tbl_classificacao
			on tbl_filme.id_classificacao = tbl_classificacao.id
 
union all
            
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		right join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		right join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		left join tbl_classificacao
			on tbl_filme.id_classificacao = tbl_classificacao.id;
            
            
            
            
desc tbl_filme;
insert into tbl_filme (
						nome, 
                        nome_original, 
                        data_lancamento, 
                        data_relancamento,
                        duracao, 
                        foto, 
                        sinopse, 
                        id_classificacao, 
                        valor_unitario
                        ) values (
                        'A LISTA DE SCHINDLER',
                        'Schindler s List',
                        '1993-12-31',
                        '2019-05-01',
                        '03:15:00',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/10/19/44/2904073.jpg',
                        'A inusitada história de Oskar Schindler (Liam Neeson), um sujeito oportunista, sedutor, "armador", simpático, comerciante no mercado negro, mas, acima de tudo, um homem que se relacionava muito bem com o regime nazista, tanto que era membro do próprio Partido Nazista (o que não o impediu de ser preso algumas vezes, mas sempre o libertavam rapidamente, em razão dos seus contatos). No entanto, apesar dos seus defeitos, ele amava o ser humano e assim fez o impossível, a ponto de perder a sua fortuna mas conseguir salvar mais de mil judeus dos campos de concentração.',
                        13,
                        '29.70'
                        );
                        
insert into tbl_genero (nome) values ('Histórico'),('Guerra');

                                                    