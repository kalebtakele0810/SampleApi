package com.safaricom.SampleApi.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "api/students")
public class UserController {

	@Autowired
	private UserService userService;

	@PostMapping
	public void addUser(@Validated @RequestBody User user) {
		userService.addUser(user);
	}

}
