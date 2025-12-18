-- =====================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS - PLATAFORMA IAG
-- Base de Datos: plataforma_iag
-- Descripción: Plataforma de Inteligencia Artificial Generativa
-- =====================================================

-- Eliminar base de datos si existe (¡CUIDADO! Elimina todos los datos)
DROP DATABASE IF EXISTS plataforma_iag;

-- Crear base de datos con codificación UTF-8
CREATE DATABASE plataforma_iag
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Seleccionar la base de datos
USE plataforma_iag;

-- =====================================================
-- TABLA: usuarios
-- Descripción: Almacena información de usuarios y administradores
-- =====================================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'usuario') NOT NULL DEFAULT 'usuario',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_rol (rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- TABLA: categorias
-- Descripción: Categorías para clasificar contenidos
-- =====================================================
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    icono VARCHAR(50),
    color VARCHAR(20),
    INDEX idx_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- TABLA: contenidos
-- Descripción: Almacena artículos, tips, noticias, etc.
-- =====================================================
CREATE TABLE contenidos (
    id_contenido INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    cuerpo TEXT NOT NULL,
    tipo ENUM('articulo', 'tip', 'noticia', 'tutorial', 'recurso') NOT NULL DEFAULT 'articulo',
    estado ENUM('publicado', 'borrador') NOT NULL DEFAULT 'borrador',
    vistas INT DEFAULT 0,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_admin INT NOT NULL,
    FOREIGN KEY (id_admin) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    INDEX idx_tipo (tipo),
    INDEX idx_estado (estado),
    INDEX idx_fecha (fecha_publicacion),
    INDEX idx_admin (id_admin)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- TABLA: contenido_categorias
-- Descripción: Relación muchos a muchos entre contenidos y categorías
-- =====================================================
CREATE TABLE contenido_categorias (
    contenido_id INT NOT NULL,
    categoria_id INT NOT NULL,
    PRIMARY KEY (contenido_id, categoria_id),
    FOREIGN KEY (contenido_id) REFERENCES contenidos(id_contenido) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria) ON DELETE CASCADE,
    INDEX idx_contenido (contenido_id),
    INDEX idx_categoria (categoria_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- DATOS INICIALES
-- =====================================================

-- Insertar usuarios de prueba
-- Contraseñas hasheadas con SHA-256:
-- admin123 = 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
-- user123  = a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3

INSERT INTO usuarios (nombre, email, password_hash, rol) VALUES
('Administrador Principal', 'admin@plataformaiag.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin'),
('Usuario Demo', 'usuario@plataformaiag.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'usuario'),
('Bryan Developer', 'bryan@plataformaiag.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin');

-- Insertar categorías predeterminadas
INSERT INTO categorias (nombre, descripcion, icono, color) VALUES
('Texto', 'Generación de contenido textual con IA', '📝', '#3b82f6'),
('Imagen', 'Creación y edición de imágenes con IA', '🎨', '#ec4899'),
('Audio/Video', 'Procesamiento de audio y video con IA', '🎵', '#8b5cf6'),
('Código', 'Generación y análisis de código con IA', '💻', '#10b981'),
('Chatbots', 'Sistemas conversacionales y asistentes virtuales', '🤖', '#f59e0b'),
('Análisis de Datos', 'Procesamiento y análisis de datos con IA', '📊', '#06b6d4');

-- Insertar contenidos de ejemplo
INSERT INTO contenidos (titulo, cuerpo, tipo, estado, vistas, id_admin) VALUES
(
    '¿Qué es la Inteligencia Artificial Generativa?',
    'La Inteligencia Artificial Generativa es una rama de la IA que se enfoca en crear contenido nuevo y original. A diferencia de los sistemas de IA tradicionales que clasifican o analizan datos, la IA generativa puede producir texto, imágenes, música, código y más.\n\nEsta tecnología utiliza modelos de aprendizaje profundo como GPT (Generative Pre-trained Transformer) para texto, DALL-E o Stable Diffusion para imágenes, y otros modelos especializados para diferentes tipos de contenido.\n\nLas aplicaciones de la IA generativa son vastas: desde la creación de contenido para marketing, hasta la asistencia en programación, diseño gráfico, composición musical y mucho más. Su capacidad para entender contextos complejos y generar resultados coherentes la hace una herramienta revolucionaria en el mundo digital actual.',
    'articulo',
    'publicado',
    125,
    1
),
(
    'Cómo usar ChatGPT para mejorar tu productividad',
    'ChatGPT puede ser tu asistente personal para aumentar la productividad:\n\n1. Redacción de emails: Pide a ChatGPT que redacte correos profesionales.\n2. Resúmenes rápidos: Obtén resúmenes de documentos largos.\n3. Lluvia de ideas: Genera ideas creativas para proyectos.\n4. Aprendizaje rápido: Explica conceptos complejos de forma simple.\n5. Corrección de textos: Revisa gramática y estilo.\n\nRecuerda siempre revisar y personalizar las respuestas según tus necesidades específicas.',
    'tip',
    'publicado',
    89,
    1
),
(
    'OpenAI presenta GPT-4.5: Mayor capacidad multimodal',
    'OpenAI ha anunciado el lanzamiento de GPT-4.5, la última versión de su modelo de lenguaje. Esta actualización trae mejoras significativas en:\n\n- Comprensión de imágenes y videos\n- Generación de código más precisa\n- Razonamiento matemático avanzado\n- Mayor ventana de contexto (128K tokens)\n- Respuestas más rápidas\n\nLa nueva versión estará disponible para usuarios de ChatGPT Plus y Enterprise a partir del próximo mes.',
    'noticia',
    'publicado',
    234,
    1
),
(
    'Tutorial: Creando imágenes con DALL-E 3',
    'Aprende a crear imágenes impresionantes con DALL-E 3:\n\nPaso 1: Define tu idea claramente\nSé específico sobre lo que quieres ver. Por ejemplo: "Un gato astronauta en un bosque de cristal, estilo acuarela"\n\nPaso 2: Especifica el estilo\nMenciona estilos artísticos: fotorrealista, cartoon, pintura al óleo, pixel art, etc.\n\nPaso 3: Añade detalles de iluminación\nDescribe la iluminación: "luz dorada del atardecer", "neón cyberpunk", "luz natural suave".\n\nPaso 4: Especifica composición\nIndica el encuadre: plano general, primer plano, vista cenital, etc.\n\nPaso 5: Itera y refina\nSi el resultado no es perfecto, ajusta tu prompt basándote en lo que obtuviste.\n\nConsejo Pro: Usa referencias culturales o artísticas conocidas para guiar el estilo.',
    'tutorial',
    'publicado',
    178,
    3
),
(
    'Recursos gratuitos para aprender IA Generativa',
    'Lista de recursos gratuitos para comenzar con IA Generativa:\n\n**Cursos Online:**\n- Fast.ai - Practical Deep Learning for Coders\n- Google AI - Machine Learning Crash Course\n- DeepLearning.AI - Generative AI for Everyone\n\n**Plataformas de Práctica:**\n- Hugging Face - Modelos y datasets\n- Google Colab - Notebooks gratuitos\n- Kaggle - Competencias y datasets\n\n**Herramientas Gratuitas:**\n- Stable Diffusion (código abierto)\n- ChatGPT versión gratuita\n- Google Bard\n- Bing Image Creator\n\n**Comunidades:**\n- r/MachineLearning (Reddit)\n- Hugging Face Forums\n- Discord de Stable Diffusion\n\n¡Comienza tu viaje en IA hoy mismo!',
    'recurso',
    'publicado',
    156,
    3
),
(
    'Próximo artículo sobre ética en IA',
    'Este es un borrador sobre las consideraciones éticas en el desarrollo de IA...',
    'articulo',
    'borrador',
    0,
    1
);

-- Asignar categorías a contenidos
INSERT INTO contenido_categorias (contenido_id, categoria_id) VALUES
-- Artículo "¿Qué es la IA Generativa?" - Todas las categorías
(1, 1), (1, 2), (1, 3), (1, 4),
-- Tip ChatGPT - Texto y Chatbots
(2, 1), (2, 5),
-- Noticia GPT-4.5 - Texto y Código
(3, 1), (3, 4),
-- Tutorial DALL-E - Imagen
(4, 2),
-- Recursos - Texto, Imagen, Código
(5, 1), (5, 2), (5, 4),
-- Borrador - Texto
(6, 1);

-- =====================================================
-- VERIFICACIÓN DE DATOS
-- =====================================================

-- Mostrar resumen de datos insertados
SELECT 'USUARIOS CREADOS:' as '';
SELECT id_usuario, nombre, email, rol, fecha_registro FROM usuarios;

SELECT '' as '';
SELECT 'CATEGORÍAS CREADAS:' as '';
SELECT id_categoria, nombre, icono, color FROM categorias;

SELECT '' as '';
SELECT 'CONTENIDOS CREADOS:' as '';
SELECT id_contenido, titulo, tipo, estado, vistas FROM contenidos;

SELECT '' as '';
SELECT 'TOTAL DE REGISTROS:' as '';
SELECT
    (SELECT COUNT(*) FROM usuarios) as total_usuarios,
    (SELECT COUNT(*) FROM categorias) as total_categorias,
    (SELECT COUNT(*) FROM contenidos) as total_contenidos,
    (SELECT COUNT(*) FROM contenido_categorias) as total_relaciones;

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================
SELECT '' as '';
SELECT '✓ Base de datos "plataforma_iag" creada exitosamente' as 'RESULTADO';
SELECT '✓ Tablas creadas: usuarios, categorias, contenidos, contenido_categorias' as '';
SELECT '✓ Datos de prueba insertados correctamente' as '';
SELECT '' as '';
SELECT 'CREDENCIALES DE PRUEBA:' as '';
SELECT 'Admin:   admin@plataformaiag.com / admin123' as '';
SELECT 'Usuario: usuario@plataformaiag.com / user123' as '';
SELECT 'Developer: bryan@plataformaiag.com / admin123' as '';
