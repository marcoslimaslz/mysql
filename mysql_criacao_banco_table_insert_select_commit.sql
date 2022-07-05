create database if not exists bancodeteste;

use bancodeteste;

drop table if exists contato;
drop table if exists pessoa;
drop table if exists genero;
drop table if exists tipocontato;

create table if not exists genero(
  id_genero int not null primary key,
  nome varchar(50) not null,
  descricao varchar(1000) not null
);

insert into genero (id_genero, nome, descricao) values 
 (1, 'Cisgênero', 'É a pessoa que se identifica com o sexo biológico designado no momento de seu nascimento.'),
 (2, 'Transgênero', 'É quem se identifica com um gênero diferente daquele atribuído no nascimento.'),
 (3, 'Não-binário' ,'É alguém que não se identifica completamente com o “gênero de nascença” nem com outro gênero. Esta pessoa pode não se ver em nenhum dos papéis comuns associados aos homens e as mulheres bem como pode vivenciar uma mistura de ambos.');

create table if not exists tipocontato(
  id_tipocontato int not null primary key,
  nome varchar(50) not null,
  descricao varchar(1000) null
);

insert into tipocontato (id_tipocontato, nome, descricao) values 
  (1, 'Telefone Residencial', null), 
  (2, 'Telefone Celular', null),
  (3, 'E-mail', null);

create table if not exists pessoa(
  id_pessoa int not null primary key,
  nome varchar(100) not null,
  nome_social varchar(100) null,
  sobrenome varchar(100) not null,
  sobrenome_casado varchar(100) null,
  sexo char(1) not null,
  id_genero int not null,
  CONSTRAINT fk_pessoa_id_genero FOREIGN KEY (id_genero) REFERENCES genero (id_genero)
);

insert into pessoa (id_pessoa, nome, nome_social, sobrenome, sobrenome_casado, sexo, id_genero) values
  (1, 'Marcos', NULL, 'Lima', NULL, 'M', 1),
  (2, 'Claudio', 'Claudia', 'Pereira', 'Pereira', 'M', 2),
  (3, 'Joana', NULL, 'Carvalho', 'Carvalho', 'F', 3),
  (4, 'Maria', 'Mario', 'Fonseca', NULL, 'F', 2);

create table if not exists contato(
  id_contato int not null primary key,
  recado varchar(100) null,
  descricao varchar(255) not null,
  id_pessoa int not null,
  id_tipocontato int not null,
  CONSTRAINT fk_contato_id_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa),
  CONSTRAINT fk_contato_id_tipocontato FOREIGN KEY (id_tipocontato) REFERENCES tipocontato (id_tipocontato)
);

insert into contato (id_contato, descricao, recado, id_pessoa, id_tipocontato) values
  (1, '(41) 3233-8800', null, 1, 1),
  (2, '(41) 99999-8800', null, 2, 2),
  (3, 'abc@nada.com.br', null, 3, 3),
  (4, '(41) 99999-7700', null, 4, 1);

select p.id_pessoa, p.nome, p.nome_social, p.sobrenome, p.sobrenome_casado, 
  case 
	  when sexo = 'M' then 'Masculino' 
	  when sexo = 'F' then 'Feminino' 
  end as sexo, 
  g.nome as genero,
  c.descricao as contato,
  t.nome as tipocontato
from pessoa p
inner join genero g on g.id_genero = p.id_genero
 left join contato c on c.id_pessoa = p.id_pessoa
 left join tipocontato t on t.id_tipocontato = c.id_tipocontato;

commit;

