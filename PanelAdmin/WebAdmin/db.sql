CREATE TABLE IF NOT EXISTS especialidades (
  id int primary key auto_increment NOT NULL,
  especialidade varchar(50) not null
);

INSERT INTO especialidades (especialidade) VALUES
('Cardiologista'),
('Alergologista');

CREATE TABLE IF NOT EXISTS medicos (
  id int primary key auto_increment NOT NULL,
  nome varchar(50) NOT NULL,
  crm varchar(15) NOT NULL,
  endereco varchar(200) NOT NULL,
  cidade varchar(100) NOT NULL,
  cep varchar(8) NOT NULL,
  estado varchar(2) NOT NULL,
  pais varchar(20) NOT NULL,
  email varchar(150) UNIQUE NOT NULL,
  especialidade_id int NOT NULL,
  user_id int NOT NULL,
  constraint especialidade_fk foreign key (especialidade_id) references especialidades(id),
  constraint user_fk foreign key (user_id) references users(id)
);

INSERT INTO medicos (nome, crm, endereco, cidade, cep, estado, pais, email, especialidade_id,user_id) VALUES
('Roberto Galvão','1523336654', 'Rua Candido de Souza 570', 'João Pessoa', '58225000', 'PB', 'Brasil', 'robertomedbra.com.br',1,1),
('Pedro Queiroz','123456789', 'Rua Candido de Souza 570', 'Fortaleza', '60420440', 'CE', 'Brasil', 'pedro@medbra.com.br', 2,1);

CREATE TABLE IF NOT EXISTS casos (
  id int primary key auto_increment NOT NULL,
  titulo varchar(200) NOT NULL,
  anamnese text NOT NULL,
  email varchar(250) NOT NULL,
  estado int NOT NULL DEFAULT '1',
  medico_id int NOT NULL,
  constraint caso_fk foreign key (medico_id) references medicos(id)
);

INSERT INTO casos (titulo, anamnese, email, estado, medico_id) VALUES
('Paciente com dores lombares', 'Um paciente muito ruim, com manchar e etc.', 'paciente1@gmail.com', 1, 1),
('Paciente com vertigens', 'Um paciente muito bom, com manchar e etc.', 'pacitente2@gmail.com', 0, 2);

CREATE TABLE IF NOT EXISTS docs_comproves (
  id int primary key auto_increment NOT NULL,
  email varchar(150) UNIQUE NOT NULL,
  url_doc varchar(200) NOT NULL,
  tipo varchar(200) NOT NULL
);

INSERT INTO docs_comproves (email, url_doc, tipo) VALUES
('medico1@gmail.com', 'arquivos/294907606-iphone.svg', 'RG'),
('medico2@gmail.com', 'arquivos/1522333391-g835.png', 'RH'),
('medico3@gmail.com', 'arquivos/610924323-iphone.svg', 'RG'),
('medico4@gmail.com', 'arquivos/80392579-g835.png', 'RH');

CREATE TABLE IF NOT EXISTS pacientes (
  id int primary key auto_increment NOT NULL,
  nome varchar(50) NOT NULL,
  cpf varchar(11) NOT NULL,
  anamnese text NOT NULL,
  email varchar(150) NOT NULL
);

INSERT INTO pacientes ( nome, cpf, anamnese, email) VALUES
('João Brito', '12345678912', 'Dores nas costas', 'paciente1@gmail.com'),
('Pedro de Sousa', '14725836947', 'Rinite', 'paciente2@gmail.com'),
('Aderbal Bezerra', '15915915915', 'Alergias', 'paciente3@gmail.com'),
('Manoel Quiroz', '15915915915', 'um teste bacana aqui', 'paciente4@gmail.com');

CREATE TABLE IF NOT EXISTS propostas (
  id int primary key auto_increment NOT NULL,
  id_caso int NOT NULL,
  email_inicial varchar(250) NOT NULL,
  emal_secundario varchar(250) NULL,
  resposta text NOT NULL
);

-- usuários cadastrados no plugin admin-br

CREATE TABLE IF NOT EXISTS verificacoes (
  id int primary key auto_increment NOT NULL,
  email varchar(150) NOT NULL,
  verificado int NOT NULL DEFAULT 0
);

INSERT INTO verificacoes (email, verificado) VALUES
('educadoresnolinnux@gmail.com', 1),
('ribafs@gmail.com', 1);

