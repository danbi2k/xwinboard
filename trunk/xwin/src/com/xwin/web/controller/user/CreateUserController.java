package com.xwin.web.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.xwin.domain.user.User;
import com.xwin.service.user.UserService;
import com.xwin.web.command.UserInfoCommand;

public class CreateUserController extends SimpleFormController
{

	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception
	{
		UserInfoCommand userInfoCommand = (UserInfoCommand) command;
		
		User user = new User();
		BeanUtils.copyProperties(userInfoCommand, user);
		
		userService.createUser(user);
		List<User> userList = userService.getUserList();
		
		ModelAndView mv = new ModelAndView("user/userList");
		mv.addObject("userList", userList);
		
		return mv;		
	}	
	
	@Override
	protected ModelAndView showForm(HttpServletRequest request,
			HttpServletResponse response, BindException errors)
			throws Exception
	{
		ModelAndView mv = new ModelAndView("user/createUser");
		return mv;
	}



	private UserService userService = null;

	public void setUserService(UserService userService) {
		this.userService = userService;
	}	
}
