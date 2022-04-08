package mybootapp.dao;

import mybootapp.model.Group;
import mybootapp.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.Collection;

@Repository
@Transactional
public class DirectoryDao implements IDirectoryDao{

    @Autowired
    @PersistenceContext(unitName = "myData")
    EntityManager em;


    @Override
    public void addPerson(Person p) {
        em.persist(p);
    }

    @Override
    public void removePerson(long id) {
        Person p = em.find(Person.class, id);
        em.remove(p);
    }

    @Override
    public Person findPerson(long id) {
        return em.find(Person.class, id);
    }

    @Override
    public Person findPersonByEmail(String email) {
        String query = "SELECT p FROM Person p WHERE p.email = :email";
        TypedQuery<Person> q = em.createQuery(query, Person.class);
        q.setParameter("email", email);
        try {
            return q.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Collection<Person> findAllPersons() {
        String query = "SELECT p FROM Person p ORDER BY name ASC";
        TypedQuery<Person> q = em.createQuery(query, Person.class);
        try {
            return q.getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Collection<Person> findAllPersonsByGroup(long groupId) {
        String query = "SELECT p FROM Person p WHERE currentGroup.id = :groupId ORDER BY name ASC";
        TypedQuery<Person> q = em.createQuery(query, Person.class);
        q.setParameter("groupId", groupId);
        try {
            return q.getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Collection<Person> findPersonsByName(String name) {
        String query = "SELECT p FROM Person p WHERE p.name LIKE :name OR p.firstname LIKE :name ORDER BY name ASC";
        TypedQuery<Person> q = em.createQuery(query, Person.class);
        q.setParameter("name", "%"+name+"%");
        try {
            return q.getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void addGroup(Group g) {
        em.persist(g);
    }

    @Override
    public void removeGroup(long id) {
        Group g = em.find(Group.class, id);
        em.remove(g);
    }

    @Override
    public void updatePerson(Person person) {
        em.merge(person);
    }

    @Override
    public Collection<Group> findAllGroups() {
        String query = "SELECT g FROM Group g ORDER BY name ASC";
        TypedQuery<Group> q = em.createQuery(query, Group.class);
        try {
            return q.getResultList();
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public Group findGroup(long id) {
        return em.find(Group.class, id);
    }

    @Override
    public Collection<Group> findGroupsByName(String name) {
        String query = "SELECT g FROM Group g WHERE g.name LIKE :name ORDER BY name ASC";
        TypedQuery<Group> q = em.createQuery(query, Group.class);
        q.setParameter("name", "%"+name+"%");
        try {
            return q.getResultList();
        } catch (Exception e) {
            return null;
        }
    }
}
