-- 7 В подключенном MySQL репозитории создать базу данных “Друзья человека”

   CREATE DATABASE IF NOT EXISTS HumanFriends;
   USE HumanFriends;
-- 8 Создать таблицы с иерархией из диаграммы в БД

CREATE TABLE Commands
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30),
    description varchar(255)
);


CREATE TABLE AnimalGroup
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30)
);

CREATE TABLE AnimalGenius
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30),
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES AnimalGroup (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE KennelAnimal
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30),
    birthDate DATE,
    genius_id INT,
    FOREIGN KEY (genius_id) REFERENCES AnimalGenius (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AnimalCommands
(
    animal_id INT NOT NULL,
    command_id INT NOT NULL,

    PRIMARY KEY (animal_id, command_id),
    FOREIGN KEY (animal_id) REFERENCES KennelAnimal (id)
     ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (command_id) REFERENCES Commands (id)
     ON DELETE CASCADE  ON UPDATE CASCADE
);
-- 9 Заполнить низкоуровневые таблицы именами (животных), командами которые они выполняют и датами рождения

 USE HumanFriends;

INSERT INTO commands(name)
VALUES
 ('Служи'),
 ('Умри'),
 ('Голоп'),
 ('Поклон'),
 ('Танцуй');

INSERT INTO AnimalGroup (name)
VALUES
 ('Вьючные животные'),
 ('Домашние животные');

INSERT INTO AnimalGenius (name, group_id)
VALUES
 ('Лошадь', 1),
 ('Верблюд', 1),
 ('Осел', 1),
 ('Кошка', 2),
 ('Собака', 2),
 ('Хомяк', 2);

INSERT INTO KennelAnimal (name, birthDate, genius_id)
VALUES
 ('Багема', '2020-07-07', 1),
 ('Барон', '2021-01-01', 1),
 ('Шайна', '2021-09-25', 3),
 ('Горб', '2023-01-02', 2),
 ('Райка', '2022-04-27', 5),
 ('Гоба', '2021-08-18', 6),
 ('Валька', '2021-08-11', 4);

INSERT INTO AnimalCommands (animal_id, command_id)
VALUES
 (1, 3), (2, 3), (2, 4), (3, 4),
 (4, 5), (5, 1), (5, 4), (6, 2),
 (7, 1);
-- 10 Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

   USE HumanFriends;
   DELETE FROM KennelAnimal WHERE genius_id = 2;

   CREATE TABLE HorseAndDonkey AS
   SELECT * from KennelAnimal WHERE genius_id = 1
   UNION
   SELECT * from KennelAnimal WHERE genius_id = 3;
-- 11 Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице

   CREATE TABLE YoungAnimals AS
      SELECT id, name, birthDate, 
      datediff(curdate(),birthDate) DIV 31 as age, genius_id 
      from KennelAnimal 
      WHERE date_add(birthDate, INTERVAL 1 YEAR) < curdate() 
            AND date_add(birthDate, INTERVAL 3 YEAR) > curdate();
-- 12 Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.
   SELECT id, name, birthDate, genius_id FROM HorseDonkey
   UNION
   SELECT id, name, birthDate, genius_id FROM YoungAnimals;