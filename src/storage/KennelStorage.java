package storage;

import model.AbstractAnimal;
import model.AbstractPackAnimal;
import model.AbstractPet;
import implement.*;
import model.Skill;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class KennelStorage implements Storage{
    Map<Integer, AbstractAnimal> dbAnimals = new HashMap<>();

    public KennelStorage() {
        init();
    }

    private void init(){
        AbstractPet cat = new Cat("Валька", LocalDate.of(2021, 8, 11));

        int per = cat.getAge();

        cat.learnSkill(new Skill("Служи"));
        dbAnimals.put(cat.getId(), cat);

        AbstractPet dog = new Dog("Райка", LocalDate.of(2022, 4, 27));
        dog.learnSkill(new Skill("Служи"));
        dog.learnSkill(new Skill("Поклон"));
        dbAnimals.put(dog.getId(), dog);

        AbstractPet hamster = new Hamster("Гоба", LocalDate.of(2021, 8, 18));
        hamster.learnSkill(new Skill("Умри"));
        dbAnimals.put(hamster.getId(), hamster);

        AbstractPackAnimal horse = new Horse("Багема", LocalDate.of(2020, 7, 7));
        horse.setLoadCapacity(300);
        horse.learnSkill(new Skill("Голоп"));
        dbAnimals.put(horse.getId(), horse);

        AbstractPackAnimal horse2 = new Horse("Барон", LocalDate.of(2021, 1, 1));
        horse2.setLoadCapacity(400);
        horse2.learnSkill(new Skill("Голоп"));
        horse2.learnSkill(new Skill("Поклон"));
        dbAnimals.put(horse2.getId(), horse2);

        AbstractPackAnimal donkey = new Donkey("Шайна", LocalDate.of(2021, 9, 25));
        donkey.setLoadCapacity(500);
        donkey.learnSkill(new Skill("Покло"));
        dbAnimals.put(donkey.getId(), donkey);

        AbstractPackAnimal camel = new Camel("Горб", LocalDate.of(2023, 1, 2));
        camel.setLoadCapacity(1000);
        camel.learnSkill(new Skill("Танцуй"));
        dbAnimals.put(camel.getId(), camel);
    }
    public List<AbstractAnimal> getAllAnimals() {
        List<AbstractAnimal> result = new ArrayList<>();
        for (AbstractAnimal animal: dbAnimals.values()) {
            result.add(animal);
        }
        return result;
    }


    public AbstractAnimal getAnimalById(int animalId) {
        return dbAnimals.getOrDefault(animalId, null);
    }


    public boolean addAnimal(AbstractAnimal animal) {
        if (dbAnimals.containsKey(animal.getId())) {return false;}
        dbAnimals.put(animal.getId(), animal);
        return true;
    }


    public int removeAnimal(AbstractAnimal animal) {
        if (!dbAnimals.containsKey(animal.getId())) {
            return -1;
        }
        AbstractAnimal removed = dbAnimals.remove(animal.getId());
        return removed.getId();
    }
}