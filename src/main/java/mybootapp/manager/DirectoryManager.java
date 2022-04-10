package mybootapp.manager;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.SignatureAlgorithm;
import mybootapp.dao.IDirectoryDao;
import mybootapp.model.Group;
import mybootapp.model.Person;
import mybootapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.QueryLookupStrategy;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Collection;
import java.util.Date;
import io.jsonwebtoken.Jwts;

import javax.mail.internet.MimeMessage;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import static org.springframework.cache.interceptor.SimpleKeyGenerator.generateKey;

@Service("directoryManager")
public class DirectoryManager implements IDirectoryManager{


    @Autowired
    IDirectoryDao dao;
    @Autowired
    public JavaMailSender sender;


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

        Person p = dao.findPersonByEmail(email);

        System.err.println("[MANAGER] login p:"+p);

        if(p == null) return false;

        System.err.println("[MANAGER] "+p.getPassword()+" vs "+password);
        if(!p.getPassword().equals(password)) return false;

        System.err.println("[MANAGER] user is logged in");
        user.setIsLogged(true);
        user.setPerson(p);

        return true;
    }

    @Override
    public boolean resetPassword(String email) {

        Person p = dao.findPersonByEmail(email);
        if(p == null) return false;
        Key key = generateSigningKey() ;
        String token = Jwts.builder()
                .setSubject(p.getId().toString())
                .claim("id",p.getId())
                .setIssuedAt(new Date())
                .setExpiration(toDate(LocalDateTime.now().plusDays(1L)))
                .signWith(SignatureAlgorithm.HS512, key)
                .compact();

        System.err.println("[MANAGER] reset password token t:"+token);

        String recoveryLink = "http://localhost:8081/log/resetpassword?token="+token;
        SimpleMailMessage mail = new SimpleMailMessage();
        mail.setTo(p.getEmail());
        mail.setFrom("Admin");
        mail.setSubject("Récupération du mot de passe");
        mail.setText("Cliquez sur le lien suivant pour réinitialiser votre mot de passe : \n \n"+recoveryLink);

        sender.send(mail);

        return true;
    }

    @Override
    public boolean changePassword(String token, String password) {
        Key key = generateSigningKey();

        Claims claims = Jwts.parser().setSigningKey(key).parseClaimsJws(token).getBody();
        if(claims.getExpiration().before(new Date())) return false;
        long id = (Integer) claims.get("id");
        Person p = dao.findPerson(id);
        if(p == null) return false;

        System.err.println("[MANAGER] change password to p:"+password);
        p.setPassword(password);
        dao.updatePerson(p);
        return true;
    }

    private Date toDate(LocalDateTime localDateTime) {
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }
    private Key generateSigningKey(){
        String SECRET_KEY = new String("uneVerreVertDansUnVerreVert");
        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(SECRET_KEY);
        Key signingKey = new SecretKeySpec(apiKeySecretBytes,0,apiKeySecretBytes.length,"DES");
        return signingKey;
    }

    @Override
    public void logout(User user) {
        user.setPerson(null);
        user.setIsLogged(false);
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
