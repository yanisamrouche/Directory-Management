package mybootapp.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import java.io.Serializable;

public class User implements Serializable {


    private static final long serialVersionUID = 1L;
    private boolean isLogged = false;
    private boolean connectionError = false;

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Person person;

    public User() {
        super();
    }

    public User(Long id, Person person) {
        this.id = id;
        this.person = person;
        isLogged = true;
        connectionError=false;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public boolean getIsLogged() {
        return isLogged;
    }

    public void setIsLogged(boolean log) {
        isLogged = log;
    }

    public boolean getConnectionError() {
        return connectionError;
    }

    public void setConnectionError(boolean err) {
        connectionError = err;
    }
}
