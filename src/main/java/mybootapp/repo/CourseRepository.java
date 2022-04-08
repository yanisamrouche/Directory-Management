package mybootapp.repo;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import mybootapp.model.Course;

public interface CourseRepository extends CrudRepository<Course, Long> {

	List<Course> findByName(String name);

	List<Course> findByNameLike(String name);

}
