-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema car_center_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema car_center_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `car_center_db` DEFAULT CHARACTER SET utf8 ;
USE `car_center_db` ;

-- -----------------------------------------------------
-- Table `car_center_db`.`MARCA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`MARCA` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre_marca` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  UNIQUE INDEX `nombre_marca_UNIQUE` (`nombre_marca` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`CLIENTE` (
  `tipo_documento` VARCHAR(2) NOT NULL,
  `documento` INT NOT NULL,
  `primer_nombre` VARCHAR(30) NOT NULL,
  `segundo_nombre` VARCHAR(30) NULL,
  `primer_apellido` VARCHAR(30) NOT NULL,
  `segundo_apellido` VARCHAR(30) NULL,
  `celular` VARCHAR(10) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tipo_documento`, `documento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`VEHICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`VEHICULO` (
  `placa` VARCHAR(6) NOT NULL,
  `color` VARCHAR(30) NOT NULL,
  `cod_marca` INT NOT NULL,
  `cli_tipo_documento` VARCHAR(2) NOT NULL,
  `cli_documento` INT NOT NULL,
  PRIMARY KEY (`placa`, `cod_marca`, `cli_tipo_documento`, `cli_documento`),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC) VISIBLE,
  INDEX `fk_VEHICULO_MARCA_idx` (`cod_marca` ASC) VISIBLE,
  INDEX `fk_VEHICULO_CLIENTE1_idx` (`cli_tipo_documento` ASC, `cli_documento` ASC) VISIBLE,
  CONSTRAINT `fk_VEHICULO_MARCA`
    FOREIGN KEY (`cod_marca`)
    REFERENCES `car_center_db`.`MARCA` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VEHICULO_CLIENTE`
    FOREIGN KEY (`cli_tipo_documento` , `cli_documento`)
    REFERENCES `car_center_db`.`CLIENTE` (`tipo_documento` , `documento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`MECANICO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`MECANICO` (
  `tipo_documento` VARCHAR(2) NOT NULL,
  `documento` INT NOT NULL,
  `primer_nombre` VARCHAR(30) NOT NULL,
  `segundo_nombre` VARCHAR(30) NULL,
  `primer_apellido` VARCHAR(30) NOT NULL,
  `segundo_apellido` VARCHAR(30) NULL,
  `celular` VARCHAR(10) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `estado` CHAR(1) NOT NULL,
  PRIMARY KEY (`tipo_documento`, `documento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`FACTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`FACTURA` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `cli_tipo_documento` VARCHAR(2) NOT NULL,
  `cli_documento` INT NOT NULL,
  `descuento_servicio` INT NOT NULL COMMENT 'El descuento del servicio se modifica una vez que se supera el valor de 3\'000.000 de pesos en repuestos, y pasa a ser del 50%.',
  `limite_presupuestal` DECIMAL NOT NULL COMMENT 'El cliente predefine el límite de su presupuesto para el mantenimiento que solicita.',
  `subtotal` DECIMAL NOT NULL COMMENT 'Es el valor de la suma total por el mantenimiento.',
  `total` DECIMAL NOT NULL COMMENT 'Es el subtotal más el 19% del IVA.',
  PRIMARY KEY (`codigo`, `cli_tipo_documento`, `cli_documento`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_FACTURA_CLIENTE1_idx` (`cli_tipo_documento` ASC, `cli_documento` ASC) VISIBLE,
  CONSTRAINT `fk_FACTURA_CLIENTE`
    FOREIGN KEY (`cli_tipo_documento` , `cli_documento`)
    REFERENCES `car_center_db`.`CLIENTE` (`tipo_documento` , `documento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`MANTENIMIENTO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `estado` INT NULL,
  `cod_placa` VARCHAR(6) NOT NULL,
  `fecha` DATE NOT NULL,
  `mec_documento` INT NOT NULL,
  `mec_tipo_documento` VARCHAR(2) NOT NULL,
  `cod_factura` INT NOT NULL,
  PRIMARY KEY (`codigo`, `cod_placa`, `mec_documento`, `mec_tipo_documento`, `cod_factura`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_MANTENIMIENTO_VEHICULO1_idx` (`cod_placa` ASC) VISIBLE,
  INDEX `fk_MANTENIMIENTO_MECANICO1_idx` (`mec_tipo_documento` ASC, `mec_documento` ASC) VISIBLE,
  INDEX `fk_MANTENIMIENTO_FACTURA1_idx` (`cod_factura` ASC) VISIBLE,
  CONSTRAINT `fk_MANTENIMIENTO_VEHICULO`
    FOREIGN KEY (`cod_placa`)
    REFERENCES `car_center_db`.`VEHICULO` (`placa`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MANTENIMIENTO_MECANICO`
    FOREIGN KEY (`mec_tipo_documento` , `mec_documento`)
    REFERENCES `car_center_db`.`MECANICO` (`tipo_documento` , `documento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MANTENIMIENTO_FACTURA`
    FOREIGN KEY (`cod_factura`)
    REFERENCES `car_center_db`.`FACTURA` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`REPUESTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`REPUESTO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre_repuesto` VARCHAR(100) NOT NULL,
  `precio_unitario` DECIMAL NOT NULL,
  `unidades_inventario` INT NOT NULL,
  `proveedor` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `car_center_db`.`REPUESTO_X_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`REPUESTO_X_MANTENIMIENTO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `unidades` INT NOT NULL,
  `tiempo_estimado` INT NOT NULL,
  `cod_mantenimiento` INT NOT NULL,
  `cod_repuesto` INT NOT NULL,
  PRIMARY KEY (`codigo`, `cod_mantenimiento`, `cod_repuesto`),
  UNIQUE INDEX `REP_X_MTOS_PK_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_REPUESTO_X_MANTENIMIENTO_MANTENIMIENTO1_idx` (`cod_mantenimiento` ASC) VISIBLE,
  INDEX `fk_REPUESTO_X_MANTENIMIENTO_REPUESTO1_idx` (`cod_repuesto` ASC) VISIBLE,
  CONSTRAINT `fk_REPUESTO_X_MANTENIMIENTO_MANTENIMIENTO`
    FOREIGN KEY (`cod_mantenimiento`)
    REFERENCES `car_center_db`.`MANTENIMIENTO` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_REPUESTO_X_MANTENIMIENTO_REPUESTO`
    FOREIGN KEY (`cod_repuesto`)
    REFERENCES `car_center_db`.`REPUESTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`FOTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`FOTO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `ruta` VARCHAR(200) NULL,
  `cod_mantenimiento` INT NOT NULL,
  PRIMARY KEY (`codigo`, `cod_mantenimiento`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_FOTO_MANTENIMIENTO1_idx` (`cod_mantenimiento` ASC) VISIBLE,
  CONSTRAINT `fk_FOTO_MANTENIMIENTO`
    FOREIGN KEY (`cod_mantenimiento`)
    REFERENCES `car_center_db`.`MANTENIMIENTO` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`SERVICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`SERVICIO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre_servicio` VARCHAR(100) NOT NULL,
  `precio_minimo` DECIMAL NOT NULL COMMENT 'El precio mínimo del servicio, predeterminado por la compañía.',
  `precio_maximo` DECIMAL NOT NULL COMMENT 'El precio máximo del servicio, predeterminado por la compañía.',
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_center_db`.`SERVICIO_X_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `car_center_db`.`SERVICIO_X_MANTENIMIENTO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `tiempo_estimado` INT NOT NULL,
  `cod_servicio` INT NOT NULL,
  `cod_mantenimiento` INT NOT NULL,
  PRIMARY KEY (`codigo`, `cod_servicio`, `cod_mantenimiento`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_SERVICIO_X_MANTENIMIENTO_SERVICIO1_idx` (`cod_servicio` ASC) VISIBLE,
  INDEX `fk_SERVICIO_X_MANTENIMIENTO_MANTENIMIENTO1_idx` (`cod_mantenimiento` ASC) VISIBLE,
  CONSTRAINT `fk_SERVICIO_X_MANTENIMIENTO_SERVICIO`
    FOREIGN KEY (`cod_servicio`)
    REFERENCES `car_center_db`.`SERVICIO` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SERVICIO_X_MANTENIMIENTO_MANTENIMIENTO`
    FOREIGN KEY (`cod_mantenimiento`)
    REFERENCES `car_center_db`.`MANTENIMIENTO` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
