package mybootapp.web;

import mybootapp.manager.IDirectoryManager;
import mybootapp.model.Group;
import mybootapp.model.Person;
import mybootapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/")
public class DirectoryController {

    @Autowired
    IDirectoryManager manager;

    @Autowired
    PersonValidator validator;

    ArrayList<Person> personCache;
    ArrayList<Group> groupCache;

    @ModelAttribute("groupFormList")
    public Map<Long, String> groups() {
        Map<Long, String> groups = new LinkedHashMap<>();
        manager.findAllGroup(null).forEach(group -> {
            groups.put(group.getId(), group.getName());
        });
        return groups;
    }

    @RequestMapping("")
    public ModelAndView index(HttpSession session) {
        return new ModelAndView("index");
    }

    @RequestMapping("profiles")
    public ModelAndView showProfiles(HttpSession session, @RequestParam(required = false) Optional<Integer> id, @RequestParam(required = false) Optional<Integer> page) {
        User user = getUser(session);

        if(id.isPresent()) {
            Person person = manager.findPerson(user, id.get());
            System.err.println("[CONTROLER] profile infos b:"+person.getBirthdate()+" e:"+person.getEmail());
            return new ModelAndView("person/person", "person", person);
        } else {
            int part = 0;
            int pageSize = 10;
            if(page.isPresent()) {
                part = page.get();
                if(part < 0) part = 0;
            }

            if(personCache == null) personCache = new ArrayList<Person>(manager.findAllPersons(user));

            ArrayList<Person> persons = personCache;

            int firstIndex = part*pageSize;
            int lastIndex = part*pageSize+pageSize > persons.size() ? persons.size() : part*pageSize+pageSize;

            return new ModelAndView("person/personsList", "persons", persons.subList(firstIndex, lastIndex));
        }
    }

    @RequestMapping("profiles/find")
    public ModelAndView showProfilesFind(HttpSession session, @RequestParam("name")String name) {
        User user = getUser(session);
        final var result = manager.findPersonsByName(user, name);
        return new ModelAndView("resultSearch", "persons", result);
    }

    @RequestMapping(value = "profiles/edit", method = RequestMethod.POST)
    public String saveProfile(HttpSession session, @ModelAttribute @Valid Person p, BindingResult result) {
        User user = getUser(session);

        if(!user.getIsLogged()) return "index";
        if(user.getPerson() == null) return "index";

        validator.validate(p, result);
        if (result.hasErrors()) {
            System.err.println("[CONTROLER] profile edit errors");
            return "person/personsEdit";
        }

        Group g = manager.findGroup(user, p.getCurrentGroup().getId());
        if(g == null) return "index";
        p.setCurrentGroup(g);

        personCache = null;

        manager.updatePerson(user, p);
        user.setPerson(p);
        session.setAttribute("user", user);

        return "person/person";
    }

    @RequestMapping("groups")
    public ModelAndView showGroups(HttpSession session, @RequestParam(required = false) Optional<Integer> id, @RequestParam(required = false) Optional<Integer> page) {
        User user = getUser(session);

        if(id.isPresent()) {
            Group group = manager.findGroup(user, id.get());
            return new ModelAndView("group/group", "group", group);
        } else {
            int part = 0;
            int pageSize = 10;
            if(page.isPresent()) {
                part = page.get();
                if(part < 0) part = 0;
            }

            if(groupCache == null) groupCache = new ArrayList<Group>(manager.findAllGroup(user));
            ArrayList<Group> groups = groupCache;

            int firstIndex = part*pageSize;
            int lastIndex = part*pageSize+pageSize > groups.size() ? groups.size() : part*pageSize+pageSize;

            return new ModelAndView("group/groupList", "groupList", groups.subList(firstIndex, lastIndex));
        }
    }


    @RequestMapping("result/find")
    public ModelAndView showResult(HttpSession session, @RequestParam("name")String name){
        User userG = getUser(session);
        User userP = getUser(session);
        final var resultG = manager.findGroupsByName(userG, name);
        final var resultP = manager.findPersonsByName(userP, name);
        ModelAndView modelAndView = null;
        if(!resultP.isEmpty()){
            modelAndView = new ModelAndView("resultSearch", "persons", resultP);

        }
        if(!resultG.isEmpty()){
            modelAndView = new ModelAndView("resultSearch", "groupList", resultG);
        }

        return modelAndView;


    }

    @RequestMapping(value = "/log", method = RequestMethod.GET)
    public ModelAndView login(HttpSession session) {
        return new ModelAndView("log/login");
    }

    @RequestMapping(value = "/log", method = RequestMethod.POST)
    public ModelAndView doLogin(HttpSession session, @RequestParam("email")String email, @RequestParam("password")String password) {
        User user = getUser(session);

        System.err.println("[CONTROLER] login e:"+email+" p:"+password);

        if(manager.login(user, email, password)) {
            session.setAttribute("user", user);
            user.setConnectionError(false);
            return new ModelAndView("person/person", "person", user.getPerson());
        }
        else {
            user.setConnectionError(true);
            return new ModelAndView("log/login");
        }
    }

    @RequestMapping("/log/out")
    public ModelAndView logout(HttpSession session) {
        User user = getUser(session);
        manager.logout(user);
        session.setAttribute("user", user);
        return new ModelAndView("log/login");
    }

    private User getUser(HttpSession session) {
        User user;
        if(session.getAttribute("user") == null) {
            System.err.println("[CONTROLER] new user session ");
            user = new User();
            session.setAttribute("user", user);
        }
        else {
            user = (User) session.getAttribute("user");
            System.err.println("[CONTROLER] get existing session | logged in:"+user.getIsLogged()+" | p:"+user.getPerson());
        }
        return user;
    }



}
