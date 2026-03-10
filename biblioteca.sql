-- Criação do banco de dados
CREATE DATABASE biblioteca;

-- Selecionar banco
USE biblioteca;

-- Tabela de alunos
CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20)
);

-- Tabela de autores
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de livros
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT,
    isbn VARCHAR(20)
);

-- Tabela intermediária (N:N)
CREATE TABLE livro_autor (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

-- Tabela de empréstimos
CREATE TABLE emprestimos (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_livro INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

-- Inserção de alunos
INSERT INTO alunos (nome, email, telefone) VALUES
('João Silva', 'joao.silva@email.com', '11987654321'),
('Maria Oliveira', 'maria.oliveira@email.com', '11991234567'),
('Carlos Souza', 'carlos.souza@email.com', '11999887766'),
('Ana Costa', 'ana.costa@email.com', '11993456789');

-- Inserção de autores
INSERT INTO autores (nome) VALUES
('Machado de Assis'),
('Clarice Lispector'),
('George Orwell'),
('J.K. Rowling');

-- Inserção de livros
INSERT INTO livros (titulo, ano_publicacao, isbn) VALUES
('Dom Casmurro', 1899, '9788535914849'),
('A Hora da Estrela', 1977, '9788532502063'),
('1984', 1949, '9780451524935'),
('Harry Potter e a Pedra Filosofal', 1997, '9788532511010');


-- Relacionamento livro_autor (N:N)
INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1), -- Dom Casmurro -> Machado de Assis
(2, 2), -- A Hora da Estrela -> Clarice Lispector
(3, 3), -- 1984 -> George Orwell
(4, 4); -- Harry Potter -> J.K. Rowling


-- Inserção de empréstimos
INSERT INTO emprestimos (id_aluno, id_livro, data_emprestimo, data_devolucao) VALUES
(1, 3, '2026-03-01', '2026-03-10'),
(2, 1, '2026-03-05', '2026-03-12'),
(3, 4, '2026-03-07', '2026-03-15');

-- Listar todos os livros
SELECT * FROM livros;

-- Listar livros com seus autores
SELECT livros.titulo, autores.nome AS autor
FROM livros
JOIN livro_autor ON livros.id_livro = livro_autor.id_livro
JOIN autores ON livro_autor.id_autor = autores.id_autor;

-- Ver empréstimos com nome do aluno
SELECT alunos.nome, livros.titulo, emprestimos.data_emprestimo
FROM emprestimos
JOIN alunos ON emprestimos.id_aluno = alunos.id_aluno
JOIN livros ON emprestimos.id_livro = livros.id_livro;