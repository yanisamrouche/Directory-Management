package mybootapp.web;

import mybootapp.manager.IDirectoryManager;
import mybootapp.model.Group;
import mybootapp.model.Person;
import mybootapp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
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
    @RequestMapping("/groups/find")
    public ModelAndView showGroupsFind(HttpSession session, @RequestParam("name")String name) {
        User user = getUser(session);
        final var result = manager.findGroupsByName(user, name);
        return new ModelAndView("group/groupSearch", "groupList", result);
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
