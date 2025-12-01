
USE nuvvi;

-- Tabela usuarios
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela categoriasnuvvi
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);
INSERT INTO categorias (nome) VALUES
('Descontos'),
('Lançamentos'),
('Produtos pro cabelo'),
('Produtos pro corpo'),
('Skincare'),
('Oral care'),
('Kits'),
('Necessidades'),
('Presentes');
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    imagem VARCHAR(255),
    categoria_id INT,
    estoque INT DEFAULT 0,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL
);
CREATE TABLE carrinho (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT DEFAULT 1,
    data_adicionado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    status ENUM('pendente','pago','enviado','entregue','cancelado') DEFAULT 'pendente',
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
INSERT INTO categorias (nome) VALUES
('Creme Dental'),
('Desodorante'),
('Protetor Solar'),
('Cabelo'),
('Lip Balm'),
('Presentes');

INSERT INTO produtos (nome, preco, imagem, categoria_id, data_cadastro) VALUES
('Creme Dental Natural', 19.90, 'img2.png.avif', 1, NOW()),
('Desodorante Vegano', 24.50, 'img3.png', 2, NOW()),
('Protetor Solar FPS 50', 39.90, 'img4.png', 3, NOW()),
('Shampoo e Condicionador', 29.90, 'img5.png', 4, NOW()),
('Lip Balm Hidratante', 14.90, 'img6.png', 5, NOW()),
('Kit Presentes NUVVI', 59.90, 'img7.png', 6, NOW());

