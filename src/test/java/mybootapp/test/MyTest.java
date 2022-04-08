package mybootapp.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import mybootapp.model.Course;
import mybootapp.repo.CourseRepository;
import mybootapp.web.Starter;

@SpringBootTest
@ContextConfiguration(classes = Starter.class)
public class MyTest {

	@Autowired
	CourseRepository cr;

	@Test
	public void testSave() {
		var c = cr.save(new Course("Test 1"));
		var c2 = cr.findById(c.getId());
		assertEquals(c2.get().getName(), "Test 1");
		System.err.printf("course id = %d\n", c.getId());
	}

}
