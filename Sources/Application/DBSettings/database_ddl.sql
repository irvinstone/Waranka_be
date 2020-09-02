-- waranka.atributo definition

CREATE TABLE `atributo` (
  `atributo_id` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('LIKE','COMMENT','SHARE') NOT NULL,
  `estado` int NOT NULL,
  PRIMARY KEY (`atributo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


-- waranka.categoria definition

CREATE TABLE `categoria` (
  `categoria_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;


-- waranka.distrito definition

CREATE TABLE `distrito` (
  `distrito_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`distrito_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;


-- waranka.perfil definition

CREATE TABLE `perfil` (
  `perfil_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`perfil_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- waranka.oficio definition

CREATE TABLE `oficio` (
  `oficio_id` int NOT NULL AUTO_INCREMENT,
  `categoria_id` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`oficio_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `oficio_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`categoria_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


-- waranka.usuario definition

CREATE TABLE `usuario` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `edad` int DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `telefono` int NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `profile_id` int DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `usuario_FK` (`profile_id`),
  CONSTRAINT `usuario_FK` FOREIGN KEY (`profile_id`) REFERENCES `perfil` (`perfil_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;


-- waranka.lista definition

CREATE TABLE `lista` (
  `lista_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int NOT NULL,
  `user_id` int NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`lista_id`),
  KEY `lista_FK` (`user_id`),
  CONSTRAINT `lista_FK` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


-- waranka.recomendado definition

CREATE TABLE `recomendado` (
  `telefono` int NOT NULL,
  `distrito_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `oficio_id` int NOT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`telefono`),
  KEY `distrito_id` (`distrito_id`),
  KEY `oficio_id` (`oficio_id`),
  KEY `recomendado_FK` (`user_id`),
  CONSTRAINT `recomendado_FK` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`usuario_id`),
  CONSTRAINT `recomendado_ibfk_1` FOREIGN KEY (`distrito_id`) REFERENCES `distrito` (`distrito_id`) ON UPDATE CASCADE,
  CONSTRAINT `recomendado_ibfk_3` FOREIGN KEY (`oficio_id`) REFERENCES `oficio` (`oficio_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


-- waranka.recomendado_atributo definition

CREATE TABLE `recomendado_atributo` (
  `recomendado_atributo_id` int NOT NULL AUTO_INCREMENT,
  `atributo_id` int NOT NULL,
  `telefono` int NOT NULL,
  `valor` varchar(45) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `owner` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`recomendado_atributo_id`),
  KEY `atributo_id` (`atributo_id`),
  KEY `telefono` (`telefono`),
  CONSTRAINT `recomendado_atributo_ibfk_1` FOREIGN KEY (`atributo_id`) REFERENCES `atributo` (`atributo_id`) ON UPDATE CASCADE,
  CONSTRAINT `recomendado_atributo_ibfk_2` FOREIGN KEY (`telefono`) REFERENCES `recomendado` (`telefono`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


-- waranka.lista_recomendado definition

CREATE TABLE `lista_recomendado` (
  `lista_recomendado_id` int NOT NULL AUTO_INCREMENT,
  `lista_id` int NOT NULL,
  `telefono` int NOT NULL,
  PRIMARY KEY (`lista_recomendado_id`),
  KEY `lista_id` (`lista_id`),
  KEY `telefono` (`telefono`),
  CONSTRAINT `lista_recomendado_ibfk_1` FOREIGN KEY (`lista_id`) REFERENCES `lista` (`lista_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_recomendado_ibfk_2` FOREIGN KEY (`telefono`) REFERENCES `recomendado` (`telefono`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
