package mybootapp.dao;

import mybootapp.manager.IDirectoryManager;
import mybootapp.model.Group;
import mybootapp.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.transaction.Transactional;
import java.io.*;
import java.text.DateFormat;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

@Service("databaseFiller")
public class DataGenerator {

    List<String> names = new ArrayList<>();
    List<String> firstNames = new ArrayList<>();
    List<Group> groups = new ArrayList<>();
    public void parseFile(String filename) throws IOException {
        File file = new File(filename);
        BufferedReader br = new BufferedReader(new FileReader(file));
        String st;
        while ((st = br.readLine()) != null){
            System.out.println(st);
            String[] fullName = st.split(" ");
            names.add(fullName[1]);
            firstNames.add(fullName[0]);
        }
    }

    @Autowired
    DirectoryDao dao;

    @EventListener(ContextRefreshedEvent.class)
    public void onApplicationEvent(ContextRefreshedEvent event) throws IOException {
        parseFile("src/main/resources/static/data.csv");
        int persons = names.size();
        int groups = 100;
        event.getApplicationContext().getBean(DataGenerator.class).fillDataBase(persons,groups);
    }

    @Transactional
    public void fillDataBase(int nbrPersons, int nbrGroups){
        Group group = new Group("sans groupe");
        groups.add(group);
        dao.addGroup(group);
        for(int i=1; i <= nbrGroups; i++){
            Group g = new Group("Groupe n°"+i);
            groups.add(g);
            dao.addGroup(g);
        }
        int rand = new Random().nextInt(groups.size());
        for(int i=0; i < nbrPersons; i++){
            Person person = new Person();
            String name = names.get(i);
            String firstName = firstNames.get(i);
            Group g = groups.get(rand);

            person.setFirstname(firstName);
            person.setName(name);
            person.setBirthdate(getRandomDate());
            person.setEmail(Normalizer.normalize(name.toLowerCase()+"."+firstName.toLowerCase()+"@mail.fr", Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", ""));
            person.setWebsite(Normalizer.normalize(name.toLowerCase()+"-"+firstName.toLowerCase()+".fr", Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", ""));
            person.setCurrentGroup(g);
            person.setPassword("1234");

            dao.addPerson(person);
        }
        // add the admin
        Person admin = new Person();
        admin.setFirstname("Admin");
        admin.setName("Admin");
        admin.setBirthdate("1962-07-05");
        admin.setEmail("admin@admin.com");
        admin.setWebsite("admin.fr");
        admin.setCurrentGroup(new Group("admins"));
        admin.setPassword("1234");
        dao.addPerson(admin);

    }

    private String getRandomDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date(ThreadLocalRandom.current().nextInt() * 1000L);
        return dateFormat.format(date);
    }







}
