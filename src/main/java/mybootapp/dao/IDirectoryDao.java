package mybootapp.dao;

import mybootapp.model.Group;
import mybootapp.model.Person;

import java.util.Collection;

public interface IDirectoryDao {

    void addPerson(Person p);
    void removePerson(long id);
    Person findPerson(long id);
    Person findPersonByEmail(String email);
    Collection<Person> findAllPersons();
    Collection<Person> findAllPersonsByGroup(long groupId);
    Collection<Person> findPersonsByName(String name);

    void addGroup(Group g);
    void removeGroup(long id);
    void updatePerson(Person person);
    Collection<Group> findAllGroups();
    Group findGroup(long id);
    Collection<Group> findGroupsByName(String name);


}
