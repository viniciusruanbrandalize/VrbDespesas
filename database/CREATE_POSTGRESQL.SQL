--db despesa postgresql

create sequence public.seq_id_banco
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;

create sequence public.seq_id_bandeira
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_cartao
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_cidade
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_cofre
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_conta_bancaria
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_despesa
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_despesa_forma_pgto
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_forma_pgto
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_log_backup
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_login
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_pais
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_participante
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;

create sequence public.seq_id_recebimento
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_subtipo_despesa
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_tipo_despesa
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_usuario
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_usuario_dono_cadastro
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_uc_acao
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_uc_acesso
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_configuracao
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;
	
create sequence public.seq_id_token_api
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;

create table public.pais (
	id integer not null,
	nome varchar(60) not null,
	siscomex varchar(11),
	sped varchar(11),
	constraint pk_pais primary key (id)
);

create table public.estado (
	uf char(2) not null,
	nome varchar(30) not null,
	ibge integer not null,
	id_pais integer not null,
	constraint pk_estado primary key (uf),
	constraint fk_estado_pais foreign key (id_pais) references pais(id)
);

create table public.cidade (
	id integer not null,
	nome varchar(50) not null,
	ibge integer not null,
	uf char(2) not null,
	constraint pk_cidade primary key (id),
	constraint fk_cidade_estado foreign key (uf) references estado(uf)
);

create table public.banco (
	id integer not null,
	numero integer not null,
	nome varchar(60) not null,
	excluido boolean not null,
	constraint pk_banco primary key (id)
);

create table public.cofre (
	id integer not null,
	data_abertura date not null,
	data_contagem date,
	lotacao varchar(15) not null,
	situacao varchar(15) not null,
	qtd_nota_rs200 integer not null,
	qtd_nota_rs100 integer not null,
	qtd_nota_rs50 integer not null,
	qtd_nota_rs20 integer not null,
	qtd_nota_rs10 integer not null,
	qtd_nota_rs5 integer not null,
	qtd_nota_rs2 integer not null,
	qtd_moeda_rs1 integer not null,
	qtd_moeda_rs050 integer not null,
	qtd_moeda_rs025 integer not null,
	qtd_moeda_rs010 integer not null,
	qtd_moeda_rs005 integer not null,
	sobra decimal(7,2) not null,
	valor_total decimal(7,2) not null,
	info_adc varchar(300),
	constraint pk_cofre primary key (id)
);

create table public.configuracao (
	id integer not null,
	nome varchar(100) not null,
	descricao varchar(500) not null,
	uso varchar(500),
	valor varchar(100) not null,
	componente varchar(50),
	excluido boolean not null,
	constraint pk_configuracao primary key (id)
);

create table public.forma_pgto (
	id integer not null,
	nome varchar(60) not null,
	sigla char(3),
	excluido boolean not null,
	constraint pk_forma_pgto primary key (id)
);

create table public.log_backup (
	id integer not null,
	data date not null,
	hora time not null,
	local_arquivo varchar(200) not null,
	constraint pk_log_backup primary key (id)
);

create table public.usuario (
	id integer not null,
	nome varchar(20) not null,
	senha varchar(100) not null,
	email varchar(300) not null,
	cadastro timestamp,
	alteracao timestamp,
	excluido boolean not null,
	constraint pk_usuario primary key (id)
);

create table public.participante (
	id integer not null,
	pessoa char(1) not null,
	nome varchar(100) not null,
	fantasia varchar(100),
	cnpj varchar(14),
	ie integer,
	telefone varchar(20),
	celular varchar(20),
	email varchar(200),
	cep varchar(9),
	rua varchar(300),
	numero integer,
	complemento varchar(50),
	bairro varchar(80),
	obs varchar(300),
	cadastro timestamp,
	alteracao timestamp,
	dono_cadastro boolean not null,
	excluido boolean not null,
	id_cidade integer,
	id_usuario_cadastro integer,
	id_dono_cadastro integer,
	constraint pk_participante primary key (id),
	constraint fk_participante_cidade foreign key (id_cidade) references cidade(id),
	constraint fk_participante_usuario_cadastro foreign key (id_usuario_cadastro) references usuario(id),
	constraint fk_participante_dono_cadastro foreign key (id_dono_cadastro) references participante(id)
);

create table public.usuario_dono_cadastro (
	id integer not null,
	id_usuario integer not null,
	id_dono_cadastro integer not null,
	cadastro timestamp,
	constraint pk_usuario_dono_cadastro primary key (id),
	constraint fk_usuario_dono_cad_usuario foreign key (id_usuario) references usuario(id),
	constraint fk_usuario_dono_cad_dono_cad foreign key (id_dono_cadastro) references participante(id)
);

create table public.bandeira (
	id integer not null,
	nome varchar(60) not null,
	excluido boolean not null,
	constraint pk_bandeira primary key (id)
);

create table public.conta_bancaria (
	id integer not null,
	numero varchar(20) not null,
	agencia varchar(20) not null,
	tipo varchar(20) not null,
	cadastro timestamp,
	alteracao timestamp,
	excluido boolean not null,
	id_banco integer not null,
	id_dono_cadastro integer,
	id_usuario_cadastro integer,
	constraint pk_conta_bancaria primary key (id),
	constraint fk_conta_bancaria_banco foreign key (id_banco) references banco(id),
	constraint fk_conta_bancaria_dono_cadastro foreign key (id_dono_cadastro) references participante(id),
	constraint fk_conta_bancaria_usuario_cadastro foreign key (id_usuario_cadastro) references usuario(id)
);

create table public.pix (
	chave varchar(100) not null,
	tipo varchar(60) not null,
	cadastro timestamp,
	alteracao timestamp,
	excluido boolean not null,
	id_conta_bancaria integer not null,
	id_dono_cadastro integer,
	id_usuario_cadastro integer,
	constraint pk_pix primary key (chave),
	constraint fk_pix_conta_bancaria foreign key (id_conta_bancaria) references conta_bancaria(id),
	constraint fk_pix_dono_cadastro foreign key (id_dono_cadastro) references participante(id),
	constraint fk_pix_usuario_cadastro foreign key (id_usuario_cadastro) references usuario(id)
);

create table public.cartao (
	id integer not null,
	numero varchar(20) not null,
	tipo char(1) not null,
	aproximacao boolean not null,
	validade date not null,
	cadastro timestamp,
	alteracao timestamp,
	excluido boolean not null,
	id_bandeira integer,
	id_conta_bancaria integer not null,
	id_dono_cadastro integer,
	id_usuario_cadastro integer,
	constraint pk_cartao primary key (id),
	constraint fk_cartao_bandeira foreign key (id_bandeira) references bandeira(id),
	constraint fk_cartao_conta_bancaria foreign key (id_conta_bancaria) references conta_bancaria(id),
	constraint fk_cartao_dono_cadastro foreign key (id_dono_cadastro) references participante(id),
	constraint fk_cartao_usuario_cadastro foreign key (id_usuario_cadastro) references usuario(id)
);

create table public.tipo_despesa (
	id integer not null,
	nome varchar(100) not null,
	excluido boolean not null,
	constraint pk_tipo_despesa primary key (id)
);

create table public.subtipo_despesa (
	id integer not null,
	nome varchar(100) not null,
	excluido boolean not null,
	id_tipo_despesa integer not null,
	constraint pk_subtipo_despesa primary key (id),
	constraint fk_subtipo_tipo foreign key (id_tipo_despesa) references tipo_despesa(id)
);

create table public.despesa (
	id integer not null,
	data date not null,
	hora time not null,
	descricao varchar(100) not null,
	chave_nfe varchar(44),
	valor decimal(7,2) not null,
	desconto decimal(7,2) not null,
	frete decimal(7,2) not null,
	outros decimal(7,2) not null,
	total decimal(7,2) not null,
	paga boolean not null,
	parcela integer,
	nivel_precisao integer not null,
	cadastro timestamp,
	alteracao timestamp,
	obs varchar(300),
	id_fornecedor integer not null,
	id_subtipo integer not null,
	id_dono_cadastro integer not null,
	id_usuario_cadastro integer not null,
	constraint pk_despesa primary key (id),
	constraint fk_despesa_fornecedor foreign key (id_fornecedor) references participante(id),
	constraint fk_despesa_subtipo foreign key (id_subtipo) references subtipo_despesa(id),
	constraint fk_despesa_dono_cadastro foreign key (id_dono_cadastro) references participante(id),
	constraint fk_despesa_usuario_cadastro foreign key (id_usuario_cadastro) references usuario(id)
);

create table public.despesa_forma_pgto (
	id integer not null,
	valor decimal(7,2) not null,
	id_conta_bancaria integer,
	chave_pix varchar(100),
	id_cartao integer,
	id_despesa integer not null,
	id_forma_pgto integer not null,
	constraint pk_despesa_forma_pgto primary key (id),
	constraint fk_despesa_froma_pgto_conta foreign key (id_conta_bancaria) references conta_bancaria(id),
	constraint fk_despesa_froma_pgto_pix foreign key (chave_pix) references pix(chave),
	constraint fk_despesa_froma_pgto_cartao foreign key (id_cartao) references cartao(id),
	constraint fk_despesa_froma_pgto_despesa foreign key (id_despesa) references despesa(id),
	constraint fk_despesa_forma_pgto_forma_pgto foreign key (id_forma_pgto) references forma_pgto(id)
);

create table public.login (
	id integer not null,
	nome_pc varchar(20),
	ip_pc varchar(15),
	data date,
	hora time,
	id_usuario integer not null,
	constraint pk_login primary key (id),
	constraint fk_login_usuario foreign key (id_usuario) references usuario(id)
);

create table public.recebimento (
	id integer not null,
	tipo integer not null,
	descricao varchar(100),
	data date not null,
	hora_extra decimal(7,2) not null,
	inss decimal(7,2) not null,
	ir decimal(7,2) not null,
	valor_total decimal(7,2) not null,
	valor_base decimal(7,2) not null,
	salario13 boolean not null,
	ferias boolean not null,
	valor_13salario decimal(7,2) not null,
	valor_ferias decimal(7,2) not null,
	antecipacao decimal(7,2) not null,
	id_forma_pgto integer not null,
	id_conta_bancaria integer,
	id_pagador integer not null,
	id_dono_cadastro integer,
	id_usuario_cadastro integer,
	constraint pk_recebimento primary key (id),
	constraint fk_recebimento_forma_pgto foreign key (id_forma_pgto) references forma_pgto(id),
	constraint fk_recebimento_conta foreign key (id_conta_bancaria) references conta_bancaria(id),
	constraint fk_recebimento_dono_cadastro foreign key (id_dono_cadastro) references participante(id),
	constraint fk_recebimento_pagador foreign key (id_pagador) references participante(id),
	constraint fk_recebimento_usuario_cadastro foreign key (id_usuario_cadastro) references usuario(id)
);

alter table public.recebimento add cadastro timestamp;
alter table public.recebimento add alteracao timestamp;

create table public.uc_tela (
	nome varchar(300) not null,   /*name do form*/
	titulo varchar(300) not null, /*caption do form*/
	constraint pk_uc_tela primary key (nome)
); 

create table public.uc_acao (
	id integer not null,
	nome varchar(300) not null,    /*name da action*/
	titulo varchar(300) not null,  /*caption da action*/
	nome_uc_tela varchar(300) not null,
	constraint pk_uc_acao primary key (id),
	constraint fk_uc_acao_uc_tela foreign key (nome_uc_tela) references uc_tela(nome)
);

create table public.uc_acesso (
	id integer not null,
	id_acao integer not null,
	id_usuario integer not null,
	constraint pk_uc_acesso primary key (id),
	constraint fk_uc_acesso_uc_acao foreign key (id_acao) references uc_acao(id),
	constraint fk_uc_acesso_usuario foreign key (id_usuario) references usuario(id)
);

create table public.token_api (
	id integer not null,
	token varchar(100) not null,
	geracao timestamp not null,
	validade timestamp not null,
	excluido boolean not null,
	constraint pk_token_api primary key (id)
);

--db arquivo postgresql

create sequence public.seq_id_arquivo
	increment by 1
	minvalue 1
	maxvalue 9223372036854775807
	start 1
	cache 1
	no cycle;

create table public.arquivo (
	id integer not null, 
	nome varchar(250) not null, 
	extensao varchar(50) not null, 
	binario blob sub_type 0 not null, 
	data_hora_upload timestamp not null, 
	id_despesa integer not null,
	constraint pk_arquivo primary key (id)
);
