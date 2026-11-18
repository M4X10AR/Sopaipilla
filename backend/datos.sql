DROP DATABASE IF EXISTS Inventario;
CREATE DATABASE Inventario;
Use Inventario;
CREATE TABLE `Habilidad` (
  `ID_Habilidad` integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `Habilidad_Name` varchar(255) NOT NULL,
  `Habilidad_Descripción` varchar(255) NOT NULl
);
CREATE TABLE `Objeto` (
  `ID_Objeto` integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `ID_Habilidad` integer NOT NULL,
  `Name_Objeto` varchar(255) NOT NULL,
  `Descripción_Objeto` varchar(255) NOT NULL,
  `Key_Objeto` boolean NOT NULL,
  constraint fk_ID_Habilidad FOREIGN KEY (ID_Habilidad) REFERENCES Habilidad(ID_Habilidad)
);

INSERT INTO Habilidad (ID_Habilidad, Habilidad_Name, `Habilidad_Descripción`)
VALUES (1, "Heal", "Cura a Mario y su compañero"),
(2, "Reflowering", "Rellena los PF de Mario"),
(3, "Star Shower", "Rellena los PE de Mario"),
(4 , "Heartful Relfowering", "Cura los PV y Rellena los PF"),
(5, "Attack", "Daña al objetivo"),
(6, "Status Effect", "Buffea y/o Debuffea a Mario o al enemigo"),
(7, "Advance", "Objeto necesario para el progreso del juego")
;

INSERT INTO Objeto (ID_Habilidad, Name_Objeto, `Descripción_Objeto`, Key_Objeto)
VALUES (1, "Champiñon", "Cura a Mario o Compañero 10 PV", False),
(1, "Super Champiñon", "Cura a Mario o Compañero 20 PV", False),
(1, "Ultra Champiñon", "Cura a Mario o Compañero 50 PV", False),
(1, "Champiñon Vital", "Revive a Mario o Compañero con 5 PV", False),
(4, "Caramelo Coco", "Cura 3 PV y rellena 15 PF", False),
(2, "Caramelo Miel", "Rellena 20 PF", False),
(2, "Caramelo Gelatina", "Rellena 64 PF", False),
(4, "Chichón", "Cura 25 PV y 25 PF", False),
(6, "Chupa PV", "Quita PV al enemigo y se lo da a Mario o Compañero", False),
(6, "Concha Protectora", "Protege de ataques enemigos con un caparazón", False),
(6, "Disco Mareo", "Marea a los enemigos causando que puedan atacarse entre ellos", False),
(6, "Disfraz de Boo", "Vuelve invisble a Mario o Compañero haciendo menos probable que te ataquen", False),
(5, "Estrella Fugaz", "Ataca al enemigo con estrellas causando 5 Puntos de Daño", False),
(3, "Olla Podrida", "Baja los PV de Mario a 1 y los PF a 0 pero rellena el medidor estelar", False),
(1, "Alimento Espacial", "Cura 5 PV a Mario o Compañero", False),
(5, "Bloque POW", "Hace temblar el causando 5 Puntos de Daño a los enemigos", False),
(6, "Capote", "Te hace ondear como una bandera, haciendote mas evasivo a ataques", False),
(6, "Don Blandito", "Baja el daño de los enemigos", False),
(5, "Flor de Fuego", "Lanza bolas de fuego a los enemigo, dañando 3 PV", False),
(5, "Furia Trueno", "Ataca a los enemigos con rayos, causa 5 PV de daño", False),
(1, "Cena con Estrellas", "Cura 7 PV y cura mas PV de forma paulatina", False),
(6, "Tormenta de hielo", "Congela a los enemigos", False),
(7, "Cinturón de Campeón", "Premio otorgado al ganador del torneo", True),
(7, "Pase Dorado", "Te permite el acceso a mas objetos en el casino de Villa Viciosa", True),
(7, "Orbe Puni", "Emblema entregado por el Puni Anciano al lider de los Punis", True),
(7, "Diario Viejo", "Diario de T.Asusto, NO LO LEAS", True),
(7, "Super Bob-Bomba", "Objeto perdido que Viviana estaba buscando", True),
(7, "Letra P", "Letra que necesita Mario para recuperar su cuerpo", True),
(5, "Dinamita Nancy", "Ataca a los enemigos con una explosión", False),
(6, "Espíritu", "Cubre a Mario o Compañero de ataques enemigos", False),
(1, "Flor Seca", "Cura 1 PV", False),
(2, "Hoja Koopa", "Rellena 7 PF", False),
(2, "Hoja Dorada", "Rellena 10 PF", False),
(4, "Koopasta", "Cura 7 PV y Rellena 7 PF", False),
(4, "Melocotón", "Cura 1 PV y Rellena 2 PF", False),
(1, "Huevo Mágico", "Cura 5 PV", False),
(5, "Huevo Explosivo", "Ataca con una explosión causando 10 Puntos de Daño", False),
(6, "Oveja Sueño", "Duerme a los enemigos con una estampida de ovejas", False),
(1, "Polo", "Cura 10 PV", False),
(2, "Pirulí Fuego", "Rellena 20 PF", False),
(1, "Pirulí Eléctrico", "Cura 20 PV", False),
(6, "Reloj Parado", "Hace que los enemigos pierdan turnos", False),
(1, "Coco", "Refrescante alimento tropical, Cura 10 PV", False),
(5, "Coco Bomba", "Provoca una explosión que causa 5 Puntos de Daño", False),
(6, "Señor Mimi", "Baja el saño de los enemigos", False),
(1, "Seta Paulatina", "Cura tus PV poco a poco", False),
(7, "Llave Sombría", "Una extraña llave que no sirve en cualquier cofre", True),
(7, "Piedra Lunar", "Una piedra con extrañas propiedades", True),
(7, "Tarjeta Llave", "Una tarjeta que puede abrir Las puertas de la base de los X-naut", True),
(7, "Flecha arriba", "No está claro que puede significar", True)
;

ALTER TABLE Objeto ADD COLUMN Name_EN varchar(255);

USE Inventario;

UPDATE Objeto SET Name_EN = CASE ID_Objeto
  WHEN 1  THEN 'Mushroom'
  WHEN 2  THEN 'Super Shroom'
  WHEN 3  THEN 'Ultra Shroom'
  WHEN 4  THEN 'Life Shroom'
  WHEN 5  THEN 'Coco Candy'
  WHEN 6  THEN 'Honey Candy'
  WHEN 7  THEN 'Jelly Candy'
  WHEN 8  THEN 'Whacka Bump'
  WHEN 9  THEN 'HP Drain'
  WHEN 10 THEN 'Courage Shell'
  WHEN 11 THEN 'Dizzy Dial'
  WHEN 12 THEN 'Boo''s Sheet'
  WHEN 13 THEN 'Shooting Star'
  WHEN 14 THEN 'Trial Stew'
  WHEN 15 THEN 'Space Food'
  WHEN 16 THEN 'POW Block'
  WHEN 17 THEN 'Repel Cape'
  WHEN 18 THEN 'Mr. Softener'
  WHEN 19 THEN 'Fire Flower'
  WHEN 20 THEN 'Thunder Rage'
  WHEN 21 THEN 'Meteor Meal'
  WHEN 22 THEN 'Ice Storm'
  WHEN 23 THEN 'Champ''s Belt'
  WHEN 24 THEN 'Gold Card'
  WHEN 25 THEN 'Puni Orb'
  WHEN 26 THEN 'Ragged Diary'
  WHEN 27 THEN 'Superbombomb'
  WHEN 28 THEN 'The Letter "p"'
  WHEN 29 THEN 'Zess Dynamite'
  WHEN 30 THEN 'Fright Mask'
  WHEN 31 THEN 'Dried Bouquet'
  WHEN 32 THEN 'Turtley Leaf'
  WHEN 33 THEN 'Golden Leaf'
  WHEN 34 THEN 'Koopasta'
  WHEN 35 THEN 'Peachy Peach'
  WHEN 36 THEN 'Mystic Egg'
  WHEN 37 THEN 'Egg Bomb'
  WHEN 38 THEN 'Sleepy Sheep'
  WHEN 39 THEN 'Icicle Pop'
  WHEN 40 THEN 'Fire Pop'
  WHEN 41 THEN 'Electro Pop'
  WHEN 42 THEN 'Stopwatch'
  WHEN 43 THEN 'Coconut'
  WHEN 44 THEN 'Coconut Bomb'
  WHEN 45 THEN 'Mini Mr. Mini'
  WHEN 46 THEN 'Slow Shroom'
  WHEN 47 THEN 'Black Key'
  WHEN 48 THEN 'Moon Stone'
  WHEN 49 THEN 'Card Key'
  WHEN 50 THEN 'Up Arrow'
END
WHERE ID_Objeto BETWEEN 1 AND 50;

SELECT Name_Objeto, Name_EN FROM Objeto;