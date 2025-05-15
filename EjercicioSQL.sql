/*
4. Generar las sentencias SQL para mostrar las órdenes completas por cliente (crear el script .sql)

      a. Consultar las tablas por separado
      b. Crear los JOINS necesarios para obtener las órdenes completas por cliente
      c. Crear la vista con la consulta del paso previo

*/
-- Seleccionar la base de datos recién creada para el ejercicio
USE `classicmodels`;
SHOW TABLES;

-- A. Consultar las tablas por separado

-- CUSTOMERS
SELECT * FROM `customers`;

-- EMPLOYEES
SELECT * FROM `employees`;

-- OFFICES
SELECT * FROM `offices`;

-- ORDER DETAIL
SELECT * FROM `orderdetails`;

-- ORDERS
SELECT * FROM `orders`;

-- PAYMENTS
SELECT * FROM `payments`;

-- PRODUCTLINES
SELECT * FROM `productlines`;

-- PRODUCTS 
SELECT * FROM `products`;

-- B. Crear los JOINS necesarios para obtener las órdenes completas por cliente

SELECT `customers`.`customerNumber`,`customers`.`customerName`, `orders`.`orderNumber`,`orderdetails`.`quantityOrdered`,`products`.`productName`,`productlines`.`textDescription`
FROM `customers`
LEFT JOIN `orders`
ON `customers`.`customerNumber`=`orders`.`customerNumber`
LEFT JOIN `orderdetails`
ON `orders`.`orderNumber`= `orderdetails`.`orderNumber`
LEFT JOIN `products`
ON `products`.`productCode`= `orderdetails`.`productCode`
LEFT JOIN `productlines`
ON `productlines`.`productLine`= `products`.`productLine`;

-- C. Crear la vista con la consulta del paso previo

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `classicmodels`.`pedidos` AS
    SELECT 
        `classicmodels`.`customers`.`customerNumber` AS `customerNumber`,
        `classicmodels`.`customers`.`customerName` AS `customerName`,
        `classicmodels`.`orders`.`orderNumber` AS `orderNumber`,
        `classicmodels`.`orderdetails`.`quantityOrdered` AS `quantityOrdered`,
        `classicmodels`.`products`.`productName` AS `productName`,
        `classicmodels`.`productlines`.`textDescription` AS `textDescription`
    FROM
        ((((`classicmodels`.`customers`
        LEFT JOIN `classicmodels`.`orders` ON ((`classicmodels`.`customers`.`customerNumber` = `classicmodels`.`orders`.`customerNumber`)))
        LEFT JOIN `classicmodels`.`orderdetails` ON ((`classicmodels`.`orders`.`orderNumber` = `classicmodels`.`orderdetails`.`orderNumber`)))
        LEFT JOIN `classicmodels`.`products` ON ((`classicmodels`.`products`.`productCode` = `classicmodels`.`orderdetails`.`productCode`)))
        LEFT JOIN `classicmodels`.`productlines` ON ((`classicmodels`.`productlines`.`productLine` = `classicmodels`.`products`.`productLine`)));

-- Consultar la vista
SELECT * FROM `pedidos`;


