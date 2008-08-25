package com.xwin.service.user;

import java.util.List;

import com.xwin.dao.UserInfoDao;
import com.xwin.domain.user.User;

public class UserService
{
	public void createUser(User user)
	{
		userInfoDao.insertUserInfo(user);		
	}
	
	public List<User> getUserList()
	{
		return userInfoDao.selectUserInfoList();
	}
	
	private UserInfoDao userInfoDao = null;

	public void setUserInfoDao(UserInfoDao userInfoDao) {
		this.userInfoDao = userInfoDao;
	}
}
