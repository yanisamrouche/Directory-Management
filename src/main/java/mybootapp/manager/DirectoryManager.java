package mybootapp.manager;

import mybootapp.dao.IDirectoryDao;
import mybootapp.model.Group;
import mybootapp.model.Person;
import mybootapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service("directoryManager")
public class DirectoryManager implements IDirectoryManager{


    @Autowired
    IDirectoryDao dao;






    @Override
    public User newUser() {
        User user = new User();
        return user;
    }

    @Override
    public Person findPerson(User user, long personId) {
        if(user.getIsLogged())
            return dao.findPerson(personId);
        else {
            Person person = dao.findPerson(personId);
            person.setBirthdate(null);
            person.setEmail(null);
            return person;
        }
    }

    @Override
    public Group findGroup(User user, long groupId) {
        return dao.findGroup(groupId);
    }

    @Override
    public Collection<Person> findAllPersons(User user) {
        if(user.getIsLogged())
            return dao.findAllPersons();
        else {
            Collection<Person> persons = dao.findAllPersons();
            for(Person person : persons) {
                person.setBirthdate(null);
                person.setEmail(null);
            }
            return persons;
        }
    }

    @Override
    public Collection<Person> findAllPersonsByGroup(User user, long groupId) {
        if(user.getIsLogged())
            return dao.findAllPersonsByGroup(groupId);
        else {
            Collection<Person> persons = dao.findAllPersonsByGroup(groupId);
            for(Person person : persons) {
                person.setBirthdate(null);
                person.setEmail(null);
            }
            return persons;
        }
    }

    @Override
    public Collection<Person> findPersonsByName(User user, String name) {
        if(user.getIsLogged())
            return dao.findPersonsByName(name);
        else {
            Collection<Person> persons = dao.findPersonsByName(name);
            for(Person person : persons) {
                person.setBirthdate(null);
                person.setEmail(null);
            }
            return persons;
        }
    }

    public Collection<Group> findAllGroup(User user) {
        return dao.findAllGroups();
    }


    @Override
    public Collection<Group> findGroupsByName(User user, String name) {
        return dao.findGroupsByName(name);
    }

    @Override
    public boolean login(User user, String email, String password) {
        //TODO
        return false;
    }

    @Override
    public boolean resetPassword(String email) {
        //TODO
        return false;
    }

    @Override
    public boolean changePassword(String token, String password) {
        //TODO
        return false;
    }

    @Override
    public void logout(User user) {
        //TODO
    }

    @Override
    public void savePerson(User user, Person p) {
        if(p.getId() == user.getPerson().getId())
            dao.addPerson(p);
    }

    @Override
    public void updatePerson(User user, Person upDatedPerson) {
        System.err.println("[MANAGER] update person id:" + upDatedPerson.getId() + " vs " + user.getPerson().getId());
        if(upDatedPerson.getId().equals(user.getPerson().getId())) {
            dao.updatePerson(upDatedPerson);
        }
    }
}
